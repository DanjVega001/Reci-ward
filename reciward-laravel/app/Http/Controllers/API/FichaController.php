<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Ficha;
use App\Service\FuncionesService;

class FichaController extends Controller
{

    private $service;
    public function __construct(FuncionesService $service){
        $this->service = $service;
    }

    /**
     * @return \Illuminate\Http\Response
     * 
     * Muestra todas las fichas disponibles
     */
    public function index()
    {
        $fichas = Ficha::all();
        return response()->json($fichas, 200);
    }

    /**
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * Crea una ficha, esto solo lo puede hacer el ADMIN 
     */
    public function store(Request $request)
    {
        $id_admin = $this->service->obtenerIdAdminAutenticado();
        if (!$id_admin) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        }
        $fichas = Ficha::create([
            'nombreFicha' => $request->nombreFicha,
            'fechaCreacion' => $request->fechaCreacion,
            'fechaFin' => $request->fechaFin,
            'codigoFicha' => $request->codigoFicha,
            
        ]);
        return response()->json($fichas, 201);
    }

    /**
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Muestra solo una ficha por su id
     */
    public function show($id)
    {
        $fichas = Ficha::find($id);
        if ($fichas) {
            return response()->json($fichas, 200);
        }
        return response()->json(["error"=>"Ficha no encontrada"], 404);
    }

    /**
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Actualiza la ficha. Solo por el ADMIN
     */
    public function update(Request $request, $id)
    {
        $id_admin = $this->service->obtenerIdAdminAutenticado();
        if (!$id_admin) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        }
        $fichas = Ficha::find($id);
        if (!$fichas) {
            return response()->json(["error"=>"Ficha no encontrada"], 404);
        } else {
                $fichas->nombreFicha = $request->nombreFicha;
                $fichas->fechaCreacion = $request->fechaCreacion;
                $fichas->fechaFin = $request->fechaFin;
                $fichas->codigoFicha = $request->codigoFicha;
                $fichas->admin_id = $id_admin;
                $fichas->update();
                return response()->json($fichas, 200);
        }

    }

    /**
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Elimina la ficha en caso de ser necesario
     */
    public function destroy($id)
    {
        $fichas = Ficha::find($id);
        if ($fichas) {
            $fichas->delete();
            return response()->json("Ficha con id: ". $id . " eliminada" , 200);
        }
        return response()->json(["error"=>"Ficha no encontrada"], 404);
    }
}


