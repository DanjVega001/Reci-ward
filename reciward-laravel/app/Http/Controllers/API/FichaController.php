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
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $fichas = Ficha::all();
        return response()->json($fichas, 200);
    }

    /**
     * Show the form for creating a new resource.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
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
            'admin_id' =>$id_admin
        ]);
        return response()->json($fichas, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
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
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $fichas = Ficha::find($id);
        if (!$fichas) {
            return response()->json(["error"=>"Ficha no encontrada"], 404);
        } else {
                $fichas->nombreFicha = $request->nombreFicha;
                $fichas->fechaCreacion = $request->fechaCreacion;
                $fichas->fechaFin = $request->fechaFin;
                $fichas->codigoFicha = $request->codigoFicha;
                $fichas->admin_id = $request->admin_id;
                $fichas->update();
                return response()->json($fichas, 200);
        } 
          
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
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


