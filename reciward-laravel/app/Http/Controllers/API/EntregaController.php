<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use App\Models\Aprendiz;
use Illuminate\Http\Request;
use App\Models\Entrega;
use App\Models\Punto;
use App\Service\FuncionesService;
use App\Models\Material_has_entrega;

class EntregaController extends Controller
{

    private $service;
    public function __construct(FuncionesService $service){
        $this->service = $service;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     *//*
    public function index($documento)
    {
        $entregas = Entrega::all();
        return response()->json($entregas, 200);
    }*/

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
            if (!$idAprendiz) {
                return response()->json(["error" => "Usuario no autorizado"],403);
            }

            $entrega = Entrega::create([
                'aprendiz_id' => $idAprendiz,
                'cafeteria_id' => 1,
                'canjeada' => false,
                'puntosAcumulados' => $request->puntosAcumulados,
                'cantidadMaterial' => $request->cantidadMaterial
            ]);
            $materiales =  $request->materiales;
            foreach ($materiales as $material) {
                $materialEntregas = Material_has_entrega::create([
                    'entrega_id' => $entrega->id,
                    'material_id' => $material["id"],
                    'numeroMaterial' => $material["numeroMaterial"]
                ]);
            }

            return response()->json(["message" => "Entrega realizada"], 201);
        } catch (\Throwable $th) {
            return response()->json(["error" => $th->getMessage()], 400);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     *
     *
     * Este metodo retorna las entregas no canjeadas de un aprendiz. El perfil de cafeteria
     * podra dirigirse a una entrega para consultar la informacion de los materiales a entrgar
     * por el aprendiz
     */


    public function show($idEntrega)
    {
        $entrega = Entrega::select('id', 'cantidadMaterial', 'canjeada', 'puntosAcumulados', 'aprendiz_id')
            ->where('id', $idEntrega)
            ->where('canjeada', 0)->first();

        $aprendiz = Aprendiz::find($entrega->aprendiz_id);

        if (!$aprendiz) {
            return response()->json(["error" => "Aprendiz no encontrado"], 404);
        }
        $nombre = $aprendiz->perfil->nombre;
        $apellido = $aprendiz->perfil->apellido;

        $materiales = DB::table('materiales AS m')
                        ->join('material_has_entregas AS mhe', 'm.id', '=', 'mhe.material_id')
                        ->select('m.nombreMaterial', 'm.numeroPuntos', 'mhe.numeroMaterial')
                        ->where('mhe.entrega_id', '=', $entrega->id)->get();

        if (!$entrega) {
            return response()->json(["message" => "El aprendiz no tiene entregas por hacer"], 404);
        }
        $entrega['materiales'] = $materiales;
        return response()->json([
            'documento' => $aprendiz->numeroDocumento,
            'nombre' => $nombre,
            'apellido' => $apellido,
            'entrega' => $entrega
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $entrega = Entrega::find($id);
        if (!$entrega) {
            return response()->json(['error' => 'Entrega no encontrada'], 404);
        }
        $entrega->update([
            'cantidadMaterial' => $request->cantidadMaterial,
            'canjeada' => $request->canjeada,
            'puntosAcumulados' => $request->puntosAcumulados
        ]);
        return response()->json($entrega, 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $entrega = Entrega::find($id);
        if (!$entrega) {
            return response()->json(['error' => 'Entrega no encontrada'], 404);
        }
        $entrega->delete();
        return response()->json("Entrega con id " . $id . " eliminado", 200);
    }

    /**
     *
     * @param int $documento
     * @return Illuminate\Http\Response
     *
     * Muestra el historial de las entregas del aprendiz, para ser utilizado como seguimiento
     * de las entregas por parte del aprendiz como del admnistrador
     */

    public function historialPorApz()
    {
        try {
            $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"], 403);
        }

        $aprendiz = Aprendiz::find($idAprendiz);

        $entregasQuery = DB::table('entregas AS e')
        ->join('material_has_entregas AS mhe', 'e.id', '=', 'mhe.entrega_id')
        ->join('materiales AS m', 'm.id', '=', 'mhe.material_id')
        ->select('e.id', 'e.cantidadMaterial', 'e.canjeada', 'e.puntosAcumulados', 'm.nombreMaterial')
        ->where('e.aprendiz_id', '=', $aprendiz->id)-> orderBy('e.id', 'ASC')
        ->get();
    
    $entregasGrouped = $entregasQuery->groupBy('id');
    
    $entregas = $entregasGrouped->map(function ($entregaGroup) {
        $firstEntrega = $entregaGroup->first();
    
        $materiales = $entregaGroup->pluck('nombreMaterial')->unique()->implode(', ');
    
        return [
            'id' => $firstEntrega->id,
            'cantidadMaterial' => $firstEntrega->cantidadMaterial,
            'canjeada' => $firstEntrega->canjeada,
            'puntosAcumulados' => $firstEntrega->puntosAcumulados,
            'nombreMaterial' => $materiales,
        ];
    })->values()->all();
    
    return response()->json($entregas, 200);
    
        } catch (\Throwable $th) {
            return response()->json($th->getMessage(), 200);
        }

        
    }





    public function historialPorAdmin($documento) {
        $aprendiz = Aprendiz::where('numeroDocumento', $documento)->first();
        return $this->historial($aprendiz);
    }

    private function historial ($aprendiz) {
        if (!$aprendiz) {
            return response()->json(["error" => "Aprendiz no encontrado"], 404);
        }
        $documento = $aprendiz->numeroDocumento;
        $nombre = $aprendiz->perfil->nombre;
        $apellido = $aprendiz->perfil->apellido;
        $entregas = Entrega::select('id','cantidadMaterial', 'canjeada', 'puntosAcumulados')
            ->where('aprendiz_id', $aprendiz->id)->get();
        if (!$entregas) {
            return response()->json(["mensaje" => "El aprendiz no tiene entregas por hacer"], 200);
        }

        return response()->json([
            'documento' => $documento,
            'nombre' => $nombre,
            'apellido' => $apellido,
            'entregas' => $entregas,
        ], 200);
    }

    /**
     *
     * @param int $idEntrega
     * @return Illuminate\Http\Response
     *
     * Esta funcion se encarga de asignar los puntos de la entrega a los puntos
     * acumulados por el aprendiz, tambien cambiara el estado de la entrega a
     * canjeada. Todo esto despues de hacer valida la enrega por el perfil de
     * cafeteria.
     */
    public function validada($idEntrega)
    {

        $entrega = Entrega::find($idEntrega);
        if (!$entrega) {
            return response()->json(['error' => 'Entrega no encontrada'], 404);
        }
        if ($entrega->canjeada) {
            return response()->json(['error' => 'Entrega ya canjeada'], 404);
        }
        $puntosEntrega = $entrega->puntosAcumulados;
        $puntos = Punto::where('aprendiz_id', $entrega->aprendiz_id)->first();

        if (!$puntos) {
            $puntos = Punto::create([
                'cantidadAcumulada' => $puntosEntrega,
                'puntosUtilizados' => 0,
                'aprendiz_id' => $entrega->aprendiz_id
            ]);
        } else {
            $puntos->update([
                'cantidadAcumulada' => $puntos->cantidadAcumulada + $puntosEntrega
            ]);
        }
        $entrega->update([
            'canjeada' => 1
        ]);
        return response()->json(["message" => "Entrega validada"], 200);
    }
}
