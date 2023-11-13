<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Clasificacion;
use App\Models\Material;
use Illuminate\Http\Request;
use App\Models\Material_has_entrega;
use Illuminate\Support\Facades\DB;

class Material_has_entregaController extends Controller
{
    

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $materialEntregas = Material_has_entrega::create($request->all());
        return response()->json($materialEntregas, 201);        
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id = idEntrega
     * @return \Illuminate\Http\Response
     * 
     * Este metodo retorna los materiales de la entrega del aprendiz que selecciono el del
     * perfil de cafeteria -- este metodo es el sucesor al show del EntregaController.
     */
    public function show($idEntrega)
    {
        $materialEntregas = Material_has_entrega::where('entrega_id', $idEntrega)
        ->get();

        $materiales = array();
        $entrega = [
            'idEntrega' => $materialEntregas[0]->entrega->id,   
            'cantidadMaterial' => $materialEntregas[0]->entrega->cantidadMaterial,
            'puntosAcumulados' => $materialEntregas[0]->entrega->puntosAcumulados
        ];
        $aprendiz = [
            'idAprendiz' => $materialEntregas[0]->entrega->aprendiz->id,
            'documentoAprendiz' => $materialEntregas[0]->entrega->aprendiz->numeroDocumento,
            'nombre' => $materialEntregas[0]->entrega->aprendiz->perfil->nombre,
            'apellido' => $materialEntregas[0]->entrega->aprendiz->perfil->apellido
        ];
        foreach ($materialEntregas as $me) {
            array_push($materiales, [
                'id' => $me->material->id,
                'nombreMaterial' => $me->material->nombreMaterial,
                'numeroPuntos' => $me->material->numeroPuntos,
                'clasificacion' => $me->material->clasificacion->nombreClasificacion
            ]);           
        }
        return response()->json([
            "aprendiz" => $aprendiz,
            "entrega" => $entrega,
            "materiales" => $materiales
        ], 200);
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $materialEntregas = Material_has_entrega::find($id);
        if (!$materialEntregas) {
            return response()->json(["error" => "material_entrga no encontrado"], 404);
        }
        $materialEntregas->delete();
        return response()->json("MaterialEntrega con id ". $id . "eliminado", 200);
    }
}
