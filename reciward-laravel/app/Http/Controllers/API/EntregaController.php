<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Entrega;

class EntregaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $entregas = Entrega::all();
        return response()->json($entregas, 200); 
    }

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
     */
    public function show($id)
    {
        $entrega = Entrega::find($id);
        if (!$entrega) {
            return response()->json(['error' => 'Entrega no encontrada'], 404);
        }
        return response()->json($entrega, 200);
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
        return response()->json("Entrega con id " . $id . " eliminado", 204);
    }
}
