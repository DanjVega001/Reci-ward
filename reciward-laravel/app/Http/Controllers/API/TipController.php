<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Tip;
use App\Service\FuncionesService;

class TipController extends Controller
{

    private $service;
    public function __construct(FuncionesService $service)
    {
        $this->service = $service;
    }
    /**
     *
     * @return \Illuminate\Http\Response
     * 
     * Muestra los tips
     */
    public function index()
    {
        $tips = Tip::all();
        return response()->json($tips, 200);
    }

    /**
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * Crea un tip
     */
    public function store(Request $request)
    {
        $id_admin = $this->service->obtenerIdAdminAutenticado();
        if (!$id_admin) {
            return response()->json(["error" => "Usuario no autorizado"], 403);
        }
        $tips = Tip::create([
            'nombre_tips' => $request->nombre_tips,
            'descripcion' => $request->descripcion,
            'administrador_id' => $id_admin,

        ]);
        return response()->json($tips, 201);
    }

    /**
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Muestra un tip de ser necesario
     */
    public function show($id)
    {
        $tips = Tip::find($id);
        if ($tips) {
            return response()->json($tips, 200);
        }
        return response()->json(["error" => "Tip no encontrado"], 404);
    }

    /**
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Actualiza un Tip de ser necesario
     */
    public function update(Request $request, $id)
    {
        $id_admin = $this->service->obtenerIdAdminAutenticado();
        if (!$id_admin) {
            return response()->json(["error" => "Usuario no autorizado"], 403);
        }
        $tips = Tip::find($id);
        if (!$tips) {
            return response()->json(["error" => "Tip no encontrado"], 404);
        } else {
            $tips->nombre_tips = $request->nombre_tips;
            $tips->descripcion = $request->descripcion;
            $tips->administrador_id = $id_admin;


            $tips->update();
            return response()->json($tips, 200);
        }
    }

    /** 
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Elimina un Tip de ser necesario
     */
    public function destroy($id)
    {
        $tips = Tip::find($id);
        if ($tips) {
            $tips->delete();
            return response()->json("Tip con id: " . $id . " eliminado", 200);
        }
        return response()->json(["error" => "Tip no encontrado"], 404);
    }
}
