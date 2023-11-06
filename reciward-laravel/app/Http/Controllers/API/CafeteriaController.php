<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Cafeteria;
use Illuminate\Support\Facades\Hash;


class CafeteriaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $cafeteria = Cafeteria::all();
        return response()->json($cafeteria, 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $cafeteria = Cafeteria::create([
            'claveAcceso' => $request->claveAcceso,
            'correoCafeteria' => $request->correoCafeteria,
            'contrasenaCafeteria' => Hash::make($request->contrasenaCafeteria)        
        ]);
        return response()->json($cafeteria, 201);
    }
     /*
    public function update(Request $request, $id)
    {
        $cafeteria = Cafeteria::find($id);
        if (!$bonos) {
            return response()->json(["error"=>"Bono no encontrado"], 404);
        } else {
                $bonos->valorBono = $request->valorBono;
                $bonos->puntosRequeridos = $request->puntosRequeridos;
                $bonos->update();
                return response()->json($bonos, 200);
        } 
          
    }*/

  

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $cafeteria = Cafeteria::find($id);
        if ($cafeteria) {
            $cafeteria->delete();
            return response()->json("cafeteria con Id ". $id . " eliminado" , 200);
        }
        return response()->json(["error"=>"cafeteria no encontrada"], 404);
    }
    
}
