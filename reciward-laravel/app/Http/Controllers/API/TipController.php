<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Tip;

class TipController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tips = Tip::all();
        return response()->json($tips, 200);
    }

    /**
     * Show the form for creating a new resource.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $tips = Tip::create([
            'nombre_tips' => $request->nombre_tips,
            'descripcion' => $request->descripcion,
            'administrador_id' => $request->admin_id,
            


        ]);
        return response()->json($tips, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $tips = Tip::find($id);
        if ($tips) {
            return response()->json($tips, 200);
        }
        return response()->json(["error"=>"Tip no encontrado"], 404);
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
        $tips = Tip::find($id);
        if (!$tips) {
            return response()->json(["error"=>"Tip no encontrado"], 404);
        } else {
                $tips->nombre_tips = $request->nombre_tips;
                $tips->descripcion = $request->descripcion;
                $tips->administrador_id = $request->admin_id;
                

                $tips->update();
                return response()->json($tips, 200);
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
        $tips = Tip::find($id);
        if ($tips) {
            $tips->delete();
            return response()->json("Tip con id: ". $id . " eliminado" , 200);
        }
        return response()->json(["error"=>"Tip no encontrado"], 404);
    }
}


