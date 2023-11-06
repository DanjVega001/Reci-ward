<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Aprendiz;
use Illuminate\Http\Request;
use App\Models\Entrega;
use App\Models\Punto;
use Exception;

class EntregaController extends Controller
{
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
        $entrega = Entrega::create($request->all());
        return response()->json($entrega, 201);
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

    public function historial($documento)
    {
        $aprendiz = Aprendiz::where('numeroDocumento', $documento)->first();
        if (!$aprendiz) {
            return response()->json(["error" => "Aprendiz no encontrado"], 404);
        }
        $nombre = $aprendiz->perfil->nombre;
        $apellido = $aprendiz->perfil->apellido;
        $entregas = Entrega::select('cantidadMaterial', 'canjeada', 'puntosAcumulados')
            ->where('aprendiz_id', $aprendiz->id)->get();
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
     * 
     * @param int $idAprendiz
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
