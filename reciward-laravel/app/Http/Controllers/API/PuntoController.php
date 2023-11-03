<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Aprendiz;
use App\Models\Punto;
use Illuminate\Support\Facades\Hash;

class PuntoController extends Controller
{
   
    public function index()
    {
        $puntos = Punto::all();
        return response()->json($puntos, 200);
    }
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
    public function show($id)
    {
        $punto = Punto::create($id);
        if (!$punto) {
            return response()->json(['message' => 'Punto no encontrado'], 404);
        }response()->json($punto, 200);
    }
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
