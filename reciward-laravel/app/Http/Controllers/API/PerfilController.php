<?php

namespace App\Http\Controllers\API;
use App\Http\Controllers\Controller;
use App\Models\Aprendiz;
use Illuminate\Http\Request;
use App\Models\Perfil;
use App\Service\FuncionesService;

class PerfilController extends Controller
{
    private $service;
    public function __construct(FuncionesService $service){
        $this->service = $service;
    }

    /**
     * Show the form for creating a new resource.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $perfiles = Perfil::create([
            'apellido' => $request->apellido,
            'nombre' => $request->nombre,
            'descripcionPerfil' => $request->descripcionPerfil,
            'avatar' =>$request->avatar
        ]);
        return response()->json($perfiles, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function verPerfil()
    {
        $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        }
        $perfiles = Aprendiz::find($idAprendiz)->perfil;
        if ($perfiles) {
            return response()->json($perfiles, 200);
        }
        return response()->json(["error"=>"Perfil no encontrado"], 404);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"],403);
        }
        $perfiles = Aprendiz::find($idAprendiz)->perfil;
        if (!$perfiles) {
            return response()->json(["error"=>"Perfil no encontrado"], 404);
        } else {
                $perfiles->apellido = $request->apellido;
                $perfiles->nombre = $request->nombre;
                $perfiles->descripcionPerfil = $request->descripcion;
                $perfiles->avatar = $request->avatar;

                $perfiles->update();
                return response()->json($perfiles, 200);
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
        $perfiles = Perfil::find($id);
        if ($perfiles) {
            $perfiles->delete();
            return response()->json("Perfil con id: ". $id . " eliminado" , 200);
        }
        return response()->json(["error"=>"Perfil no encontrado"], 404);
    }
}


