<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Aprendiz;
use App\Models\Punto;
use App\Service\FuncionesService;

class PuntoController extends Controller
{
   
    private $service;
    public function __construct(FuncionesService $service){
        $this->service = $service;
    }

    /**
     *
     * @return \Illuminate\Http\Response
     * 
     * Muestra los puntos
     */
    public function index()
    {
        $puntos = Punto::all();
        return response()->json($puntos, 200);
    }
    

    /**
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * Inicializa los puntos para un aprendiz
     */
    public function store(Request $request)
    {
        $request->validate([
            'cantidadAcumulada' =>'required|integer',
            'puntosUtilizados' =>'required|integer',
            'aprendiz_id' =>'required|integer',
        ]);

        $punto = Punto::create($request->all());
        return response()->json($punto, 201);
    }


    
    /**
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Muestra los puntos de un aprendiz
     */

    public function show()
    {
        $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        }
        $punto = Aprendiz::find($idAprendiz)->puntos;
        if (!$punto) {
            return response()->json(['message' => 'Punto no encontrado'], 404);
        }return response()->json($punto, 200);
    }


    /**
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Actualiza los puntos del aprendiz
     */
    public function update(Request $request, $id)
    {
        $punto = Punto::find($id);
        if (!$punto) {
            return response()->json(['message' => 'Punto no encontrado'], 404);
        }

        $request->validate([
            'cantidadAcumulada' => 'integer',
            'puntosUtilizados' => 'integer',
            'aprendiz_id' => 'integer',
        ]);

        $punto->update($request->all());
        return response()->json($punto, 200);
    }

    
    /** 
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Elimina los puntos del aprendiz
     */
    public function destroy($id)
    {
        $punto = Punto::find($id);
        if (!$punto) {
            return response()->json(['message' => 'Punto no encontrado'], 404);
        }

        $punto->delete();
        return response()->json(['message' => 'Punto eliminado'], 200);
    }
}
