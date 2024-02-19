<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Aprendiz_has_bono;
use App\Models\Bono;
use Illuminate\Support\Str;
use App\Models\Aprendiz;
use App\Models\Punto;
use App\Service\FuncionesService;
use DateTime;

class Aprendiz_has_bonoController extends Controller
{
    private $service;
    public function __construct(FuncionesService $service){
        $this->service = $service;
    }
    /**
     * @param $idAprendiz
     * @return Response 
     * 
     */
    public function bonosPorAprendiz()
    {
        $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        }
        $aprendiz_has_bono = Aprendiz_has_bono::where('aprendiz_id', $idAprendiz)
            ->where('estadoBono', false)->get();
        if (count($aprendiz_has_bono)<1) {
            return response()->json(['message' => 'El aprendiz no tiene bonos para redimir'], 404);
        }

        $dataBonos = array();
        foreach ($aprendiz_has_bono as $apBono) {
            array_push($dataBonos, [
                'id' => $apBono->id,
                'fechaCreacion' => $apBono->fechaCreacion,
                'fechaVencimiento' => $apBono->fechaVencimiento,
                'codigoValidante' => $apBono->codigoValidante,
                'valorBono' => $apBono->bono->valorBono,
                'estadoBono' => $apBono->estadoBono
            ]);
        }
        $aprendiz = $aprendiz_has_bono[0]->aprendiz;
        $perfil = $aprendiz->perfil;

        return response()->json([
            'nombreAprendiz' => $perfil->nombre,
            'apellidoAprendiz' => $perfil->apellido,
            'documento' => $aprendiz->numeroDocumento,
            'bonos' => $dataBonos
        ], 200);
    
        return response()->json($aprendiz_has_bono, 200);
    }

    /**
     * @param $request
     * @return Response
     * 
     * Este metodo le asigna el bono elegido al aprendiz si este tiene los puntos requeridos,
     * al asignar el bono tambien se le hacen los respectivos cambios a la entidad puntos
     * del aprendiz.
     */

    public function store(Request $request)
    {
        $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        }
        $request->validate([
            'bono_id' => 'required|integer'
        ]);
        $bono = Bono::find($request->bono_id);
        $aprendiz = Aprendiz::find($idAprendiz);
        $codigoValidante = null;
        $unico = false;
        $puntos = null;
        if (!$aprendiz->puntos) {
            $puntos = Punto::create([
                'cantidadAcumulada' => 0,
                'puntosUtilizados' => 0,
                'aprendiz_id' => $aprendiz->id
            ]);    
        } else $puntos = $aprendiz->puntos;
        if ($bono->puntosRequeridos > $puntos->cantidadAcumulada) {
            return response()->json(["error"=>"No tienes puntos suficientes"], 404);
        }
        // Crear codigo unico alfanumerico de 6 caracteres
        while (!$unico) {
            $codigoValidante = Str::random(6);
            $existeCodigo = Aprendiz_has_bono::where('codigoValidante',
                $codigoValidante)->exists();
            if (!$existeCodigo) {
                $unico = true;
            }
        }
        $fechaHoy = new DateTime();
        $aprendiz_has_bono = Aprendiz_has_bono::create([
            'codigoValidante' => $codigoValidante,
            'estadoBono' => false,
            'fechaCreacion' => $fechaHoy->format('Y-m-d'),
            'fechaVencimiento' => $fechaHoy->modify('+2 weeks')
                ->format('Y-m-d'), 
            'aprendiz_id' => $aprendiz->id,
            'bono_id' => $request->bono_id,
        ]);
        $puntos->update([
            'cantidadAcumulada' => $puntos->cantidadAcumulada - $bono->puntosRequeridos,
            'puntosUtilizados' => $puntos->puntosUtilizados + $bono->puntosRequeridos
        ]);
        return response()->json(["message" => "Bono creado"], 201);
    }

    /**
     * @param $codigoValidante
     * @return Response
     * 
     * Este metodo devuelve el bono que el aprendiz creo, para ser mostrado cuando el 
     * perfil de cafeteria busque por el codigoValidante el bono del aprendiz
     */

    public function show($codigoValidante)
    {
        $aprendiz_has_bono = Aprendiz_has_bono::where('codigoValidante', $codigoValidante)->first();

        if ($aprendiz_has_bono===null || $aprendiz_has_bono->estadoBono) {
            return response()->json(['message' => 'Bono no encontrado'], 404);
        }
        $aprendiz = $aprendiz_has_bono->aprendiz;
        $bono = $aprendiz_has_bono->bono;
        $perfil = $aprendiz->perfil;

        return response()->json([
            'id' => $aprendiz_has_bono->id,
            'nombreAprendiz' => $perfil->nombre,
            'apellidoAprendiz' => $perfil->apellido,
            'documento' => $aprendiz->numeroDocumento,
            'fechaVencimiento' => $aprendiz_has_bono->fechaVencimiento,
            'valorBono' => $bono->valorBono
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $aprendiz_has_bono = Aprendiz_has_bono::find($id);
        if (!$aprendiz_has_bono) {
            return response()->json(['message' => 'Aprendiz_has_bono no encontrado'], 404);
        }

        $aprendiz_has_bono->update([
            'estadoBono' => $request->estadoBono	
        ]);
        return response()->json($aprendiz_has_bono, 200);
    }

    public function destroy($id)
    {
        $aprendiz_has_bono = Aprendiz_has_bono::find($id);
        if (!$aprendiz_has_bono) {
            return response()->json(['message' => 'Aprendiz_has_bono no encontrado'], 404);
        }

        $aprendiz_has_bono->delete();
        return response()->json(['message' => 'Aprendiz_has_bono eliminado'], 200);
    }
}
