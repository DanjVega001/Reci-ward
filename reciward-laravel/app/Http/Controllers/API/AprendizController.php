<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Aprendiz;
use App\Models\Ficha;
use App\Service\FuncionesService;
use Illuminate\Support\Facades\Hash;

class AprendizController extends Controller
{

    private $service;
    public function __construct(FuncionesService $service){
        $this->service = $service;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        $aprendices = Aprendiz::all();
        $data_aprendices = array();
        foreach ($aprendices as $ap) {
            array_push($data_aprendices, array(
                'id' => $ap->id,
                'tipoDocumento' => $ap->tipoDocumento,
                'numeroDocumento' => $ap->numeroDocumento,
                'contrasena' => $ap->contrasena,
                'correo' =>  $ap->correo,
                'numeroFicha' => $ap->ficha->codigoFicha,
                //'apellido' => $ap->perfil->apellido,
                //'nombre' => $ap->perfil->nombre
            ));
        }
        return response()->json($data_aprendices, 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $aprendices = Aprendiz::create([
            'tipoDocumento' => $request->tipoDocumento,
            'numeroDocumento' => $request->numeroDocumento,
            'correo' => $request->correo,
            'contrasena' => Hash::make($request->contrasena),
            'ficha_id' => $request->ficha_id,
            'user_id' => $request->user_id
        ]);
        return response()->json($aprendices, 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $ap = Aprendiz::find($id);
        if (!$ap) {       
            return response()->json(["error"=>"Aprendiz no encontrado"], 404);
        }
        $aprendiz = array(
            'tipoDocumento' => $ap->tipoDocumento,
            'numeroDocumento' => $ap->numeroDocumento,
            'password' => $ap->contrasena,
            'email' =>  $ap->correo,
            'numeroFicha' => $ap->ficha->codigoFicha,
            'apellido' => $ap->perfil->apellido,
            'name' => $ap->perfil->nombre
        );
        
        return response()->json($aprendiz, 200);
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
        $aprendiz = Aprendiz::find($idAprendiz);
        if (!$aprendiz) {
            return response()->json(["error"=>"Aprendiz no encontrado"], 404);
        } 
        if ($request->contrasenaAntigua && $request->contrasena) {
            if (Hash::check($request->contrasenaAntigua, $aprendiz->contrasena)) {
                $aprendiz->tipoDocumento = $request->tipoDocumento;
                $aprendiz->numeroDocumento = $request->numeroDocumento;
                $aprendiz->correo = $request->correo;
                $aprendiz->contrasena = Hash::make($request->contrasena);
                $aprendiz->update();
                return response()->json($aprendiz, 200);
            } else {
                return response()->json(["error"=>"Las contraseñas no coinciden"], 400);
            }
        } else {
            $aprendiz->tipoDocumento = $request->tipoDocumento;
            $aprendiz->correo = $request->correo;
            $aprendiz->numeroDocumento = $request->numeroDocumento;
            $aprendiz->update();
            return response()->json($aprendiz, 200);
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
        $aprendiz = Aprendiz::find($id);
        if ($aprendiz) {
            $aprendiz->delete();
            return response()->json("Aprendiz con id: ". $id. " eliminado", 200);
        }
        return response()->json(["error"=>"Aprendiz no encontrado"], 404);
    }
}
