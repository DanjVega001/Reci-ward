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
            foreach ($materiales as $material_id) {
                $materialEntregas = Material_has_entrega::create([
                    'entrega_id' => $entrega->id,
                    'material_id' => $material_id
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


    public function show($documento)
    {
        $aprendiz = Aprendiz::where('numeroDocumento', $documento)->first();
        if (!$aprendiz) {
            return response()->json(["error" => "Aprendiz no encontrado"], 404);
        }
        $nombre = $aprendiz->perfil->nombre;
        $apellido = $aprendiz->perfil->apellido;
        $entregas = Entrega::select('id', 'cantidadMaterial', 'canjeada', 'puntosAcumulados')
            ->where('aprendiz_id', $aprendiz->id)
            ->where('canjeada', 0)->get();
        if (!$entregas) {
            return response()->json(["mensaje" => "El aprendiz no tiene entregas por hacer"], 200);
        }
        return response()->json([
            'documento' => $documento,
            'nombre' => $nombre,
            'aprellido' => $apellido,
            'entregas' => $entregas
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

    public function historialPorApz($id)
    {
        $idAprendiz =  $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        } 
        $aprendiz = Aprendiz::find($idAprendiz);
        $query = DB::table('entregas AS mhe')
                    ->join('materiales_has_entregas AS mhe', 'e.id','=','mhe.entrega_id')
                    ->join('materiales AS m','m.id','=','mhe.material_id')
                    ->select('e.id', 'e.cantidadMaterial','e.canjeada','e.puntosAcumulados','m.nombreMaterial')
                    ->where('e.aprendiz','=',$aprendiz->id)
                    ->get();
        
        $entregas = [];

        foreach ($query as $row){
            $id = $row->id;

            if (!isset($entregas[$id])){
                $entregas[$id] = [
                    'id' => $id,
                    'cantidadMaterial' => $row->cantidadMaterial,
                    'canjeada' => $row->canjeada,
                    'puntosAcumulados' => $row->puntosAcumulados,
                    'nombreMaterial' => [$row->nombreMaterial]
                ];
            } else {
                $entregas[$id]['nombreMaterial'][]= $row->nombreMaterial;
                }
            }
            $entregas = array_values($entregas);
            
            return responde()->json($entregas, 200);  
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
            'entregas' => $entregas
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
        return response()->json("Cambios en postvalidacion hechos", 200);
    }
}
