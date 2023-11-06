<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Ficha;

class FichaController extends Controller
{
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
        $fichas = Ficha::create([
            'nombreFicha' => $request->nombreFicha,
            'fechaCreacion' => $request->fechaCreacion,
            'fechaFin' => $request->fechaFin,
            'codigoFicha' => $request->codigoFicha,
            'admin_id' =>$request->admin_id
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
                $fichas->nombreFicha = $request->nombraFicha;
                $fichas->fechaCreacion = $request->fechaCreacion;
                $fichas->fechaFin = $request->fechaFin;
                $fichas->codigo = $request->codigo;
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


