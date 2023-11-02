<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Clasificacion;
use Illuminate\Support\Facades\Hash;
class ClasificacionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $clasificaciones = Clasificacion::all();
        return response()->json($clasificaciones, 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'nombreClasificacion' => 'required|string',
            
        ]);

        $clasificacion = Clasificacion::create($request->all());
        return response()->json($clasificacion, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $clasificacion = Clasificacion::find($id);
        if (!$clasificacion) {
            return response()->json(['message' => 'Clasificacion no encontrada'], 404);
        }

        return response()->json($clasificacion, 200);
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
        $request->validate([
            'nombreClasificacion' => 'required|string',
            
        ]);

        $clasificacion = Clasificacion::find($id);
        if (!$clasificacion) {
            return response()->json(['message' => 'Clasificacion no encontrada'], 404);
        }

        $clasificacion->update($request->all());
        return response()->json($clasificacion, 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $clasificacion = Clasificacion::find($id);
        if (!$clasificacion) {
            return response()->json(['message' => 'Clasificacion no encontrada'], 404);
        }

        $clasificacion->delete();
        return response()->json(['message' => 'Clasificacion eliminada'], 200);
    }
}

