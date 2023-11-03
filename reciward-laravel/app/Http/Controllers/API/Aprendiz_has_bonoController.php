<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Aprendiz_has_bono;

class Aprendiz_has_bonoController extends Controller
{
    public function index()
    {
        $aprendices_has_bono = Aprendiz_has_bono::all();
        return response()->json($aprendices_has_bono, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'codigoValidante' => 'required|integer',
            'estadoBono' => 'required',
            'fechaCreacion' => 'required|datetime',
            'fechaVencimiento' => 'required|datetime',
            'aprendiz_id' => 'required|integer',
            'bono_id' => 'required|integer',
        ]);

        $aprendiz_has_bono = Aprendiz_has_bono::create($request->all());
        return response()->json($aprendiz_has_bono, 201);
    }

    public function show($id)
    {
        $aprendiz_has_bono = Aprendiz_has_bono::find($id);
        if (!$aprendiz_has_bono) {
            return response()->json(['message' => 'Aprendiz_has_bono no encontrado'], 404);
        }
        return response()->json($aprendiz_has_bono, 200);
    }

    public function update(Request $request, $id)
    {
        $aprendiz_has_bono = Aprendiz_has_bono::find($id);
        if (!$aprendiz_has_bono) {
            return response()->json(['message' => 'Aprendiz_has_bono no encontrado'], 404);
        }

        $request->validate([
            'codigoValidante' => 'required|integer',
            'estadoBono' => 'required',
            'fechaCreacion' => 'required|datetime',
            'fechaVencimiento' => 'required|datetime',
            'aprendiz_id' => 'required|integer',
            'bono_id' => 'required|integer',
        ]);

        $aprendiz_has_bono->update($request->all());
        return response()->json($aprendiz_has_bono, 200);
    }

    public function destroy($id)
    {
        $aprendiz_has_bono = Aprendiz_has_bono::find($id);
        if (!$aprendiz_has_bono) {
            return response()->json(['message' => 'Aprendiz_has_bono no encontrado'], 404);
        }

        $aprendiz_has_bono->delete();
        return response()->json(['message' => 'Aprendiz_has_bono eliminado'], 200);
    }
}
