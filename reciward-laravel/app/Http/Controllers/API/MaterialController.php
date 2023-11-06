<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Material;
use App\Models\Clasificacion;
use Illuminate\Support\Facades\Hash;

class MaterialController extends Controller
{
    public function index()
    {
        $materiales = Material::all();
        $materiales_data = array();
        foreach ($materiales as $material) {
            array_push($materiales_data, [
                "nombreMaterial" => $material->nombreMaterial,
                "numeroPuntos" => $material->numeroPuntos,
                "clasificacion" => $material->clasificacion->nombreClasificacion,
                "id" => $material->id
            ]);
        }
        return response()->json($materiales_data, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombreMaterial' => 'required|string',
            'numeroPuntos' => 'required|integer',
            'clasificacion_id' => 'required|integer',
        ]);

        $material = Material::create($request->all());
        return response()->json($material, 201);
    }

    public function show($id)
    {
        $material = Material::find($id);
        if (!$material) {
            return response()->json(['message' => 'Material no encontrado'], 404);
        }
        $materiales_data = array();
        array_push($materiales_data, [
            "nombreMaterial" => $material->nombreMaterial,
            "numeroPuntos" => $material->numeroPuntos,
            "clasificacion" => $material->clasificacion->nombreClasificacion,
            "id" => $material->id
        ]);
        return response()->json($materiales_data, 200);
    }

    public function update(Request $request, $id)
    {
        $material = Material::find($id);
        if (!$material) {
            return response()->json(['message' => 'Material no encontrado'], 404);
        }
        $request->validate([
            'nombreMaterial' => 'string',
            'numeroPuntos' => 'integer',
            'clasificacion_id' => 'required|integer',
        ]);

        $material->update($request->all());
        return response()->json($material, 200);
    }

    public function destroy($id)
    {
        $material = Material::find($id);
        if (!$material) {
            return response()->json(['message' => 'Material no encontrada'], 404);
        }

        $material->delete();
        return response()->json(['message' => 'Material eliminado'], 200);
    }
}
