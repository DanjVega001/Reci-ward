<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bono;

class BonoController extends Controller
{
    /**
     * 
     *
     * @return \Illuminate\Http\Response
     * 
     * Obtiene todos los bonos disponibles para canjear por puntos
     */
    public function index()
    {
        $bonos = Bono::all();
        return response()->json($bonos, 200);
    }

    /**
     * 
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * Crea un bono. Esto solo lo puede hacer el admin
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
     * 
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
     * 
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Actualiza el bono. Esto lo puede hacer tanto el admin como el de cafetería 
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
                return response()->json(["message" => "Bono actualizado"], 200);
        } 
          
    }

    /**
     * 
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Elimina. Esto solo lo puede hacer el admin
     */
    public function destroy($id)
    {
        try {
            $bonos = Bono::find($id);
            if ($bonos) {
                $bonos->delete();
                return response()->json("Bono con id: ". $id . " eliminado" , 200);
            }
            return response()->json(["error"=>"Bono no encontrado"], 404);
        } catch (\Throwable $th) {
            return response()->json(["error"=>$th->getMessage()], 400);

        }
        
    }
}


