<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Administrador;
use Illuminate\Support\Facades\Hash;

class AdministradorController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $administrador = Administrador::all();
        return response()->json($administrador, 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $administrador = Administrador::create([
            'nombreAdmin' => $request->nombreAdmin,
            'correoAdmin' => $request->correoAdmin,
            'contrasenaAdmin' => Hash::make($request->contrasenaAdmin)
        ]);
        return response()->json($administrador, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $administrador = Administrador::find($id);
        if ($administrador) {
            return response()->json($administrador, 200);
        }
        return response()->json(["error"=>"Administrador no encontrado"], 404);
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
        $administrador = Administrador::find($id);
        if (!$administrador) {
            return response()->json(["error"=>"Administrador no encontrado"], 404);
        }
        if ($request->contrasenaAntigua && $request->contrasenaAdmin) {
            if (Hash::check($request->contrasenaAntigua, $administrador->contrasenaAdmin)) {
                $administrador->nombreAdmin = $request->nombreAdmin;
                $administrador->correoAdmin = $request->correoAdmin;
                $administrador->contrasenaAdmin = Hash::make($request->contrasenaAdmin);
                $administrador->update();
                return response()->json($administrador, 200);
            } else {
                return response()->json(["error"=>"Las contraseñas no coinciden"], 400);
            }
        } else {
            $administrador->nombreAdmin = $request->nombreAdmin;
            $administrador->correoAdmin = $request->correoAdmin;
            $administrador->update();
            return response()->json($administrador, 200);
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
        $administrador = Administrador::find($id);
        if ($administrador) {
            $administrador->delete();
            return response()->json("Administrador con id: ". $id . " eliminado" , 200);
        }
        return response()->json(["error"=>"Administrador no encontrado"], 404);
    }
}
