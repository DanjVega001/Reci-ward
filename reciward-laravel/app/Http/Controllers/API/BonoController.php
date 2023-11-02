<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bono;

class BonoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $bonos = Bono::all();
        return response()->json($bonos, 200);
    }

    /**
     * Show the form for creating a new resource.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $bonos = Bono::create([
            'valorBono' => $request->valorBono,
            'puntosRequeridos' => $request->puntosRequeridos,
        ]);
        return response()->json($bonos, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $bonos = Bono::find($id);
        if ($bonos) {
            return response()->json($bonos, 200);
        }
        return response()->json(["error"=>"Bono no encontrado"], 404);
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
        $bonos = Bono::find($id);
        if (!$bonos) {
            return response()->json(["error"=>"Bono no encontrado"], 404);
        } else {
                $bonos->valorBono = $request->valorBono;
                $bonos->puntosRequeridos = $request->puntosRequeridos;
                $bonos->update();
                return response()->json($bonos, 200);
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
        $bonos = Bono::find($id);
        if ($bonos) {
            $bonos->delete();
            return response()->json("Bono con id: ". $id . " eliminado" , 200);
        }
        return response()->json(["error"=>"Bono no encontrado"], 404);
    }
}


