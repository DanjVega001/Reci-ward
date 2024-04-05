<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Material;
use Illuminate\Support\Facades\Hash;

class MaterialController extends Controller
{

    /**
     * 
     * @return \Illuminate\Http\Response
     * 
     * Muestra todas los materiales disponibles
     */
    public function index()
    {
        $materiales = Material::all();
        $materiales_data = array();
        foreach ($materiales as $material) {
            array_push($materiales_data, [
                "nombreMaterial" => $material->nombreMaterial,
                "numeroPuntos" => $material->numeroPuntos,
                "id" => $material->id
            ]);
        }
        return response()->json($materiales_data, 200);
    }

    /**
     * @param  Request $request
     * @return \Illuminate\Http\Response
     * 
     * Crear un nuevo material. SOLO EL ADMIN
     */

    public function store(Request $request)
    {
        $request->validate([
            'nombreMaterial' => 'required|string',
            'numeroPuntos' => 'required|integer',
        ]);

        $material = Material::create($request->all());
        return response()->json($material, 201);
    }


     /**
     * @param int $id
     * @return \Illuminate\Http\Response
     * 
     * Muestra un material por su id
     */

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
            "id" => $material->id
        ]);
        return response()->json($materiales_data, 200);
    }

    /**
     * @param Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     * 
     * Actualiza el material
     */

    public function update(Request $request, $id)
    {
        $material = Material::find($id);
        if (!$material) {
            return response()->json(['message' => 'Material no encontrado'], 404);
        }
        $request->validate([
            'nombreMaterial' => 'string',
            'numeroPuntos' => 'integer',
        ]);

        $material->update($request->all());
        return response()->json($material, 200);
    }

    /**
     * @param int $id
     * @return \Illuminate\Http\Response
     * 
     * Elimina el material
     */
    public function destroy($id)
    {
        try {
            $material = Material::find($id);
            if (!$material) {
                return response()->json(['message' => 'Material no encontrada'], 404);
            }

            $material->delete();
            return response()->json(['message' => 'Material eliminado'], 200);
        } catch (\Throwable $th) {
            return response()->json(["error"=>$th->getMessage()], 400);
        }
        
    }
}
