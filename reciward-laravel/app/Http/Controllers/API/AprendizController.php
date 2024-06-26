<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Aprendiz;
use App\Models\Aprendiz_has_bono;
use App\Models\Entrega;
use App\Models\Perfil;
use App\Models\Punto;
use App\Models\User;
use App\Service\FuncionesService;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AprendizController extends Controller
{

    private $service;
    public function __construct(FuncionesService $service)
    {
        $this->service = $service;
    }
    /**
     * 
     *
     * @return \Illuminate\Http\Response
     * 
     * Muestra los datos de un aprendiz, incluyendo datos que estan dentro de la entidad Perfil
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
                'apellido' => $ap->perfil->apellido,
                'nombre' => $ap->perfil->nombre
            ));
        }
        return response()->json($data_aprendices, 200);
    }

    /**
     * 
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
     * 
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $ap = Aprendiz::find($id);
        if (!$ap) {
            return response()->json(["error" => "Aprendiz no encontrado"], 404);
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
     * 
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * Actualiza los datos del aprendiz
     */
    public function update(Request $request)
    {
        $idAprendiz = $this->service->obtenerIdAprendizAutenticado();
        if (!$idAprendiz) {
            return response()->json(["error" => "Usuario no autorizado"], 403);
        }

        $aprendiz = Aprendiz::find($idAprendiz);
        if (!$aprendiz) {
            return response()->json(["error" => "Aprendiz no encontrado"], 404);
        }

        $perfil = Perfil::where('aprendiz_id', $idAprendiz)->first();
        $user = User::where('id', $aprendiz->user_id)->first();
        if ($request->contrasenaAntigua && $request->contrasena) {
            if (Hash::check($request->contrasenaAntigua, $aprendiz->contrasena)) {

                $user->name = $request->name;
                $user->email = $request->correo;
                $user->password = Hash::make($request->contrasena);
                $aprendiz->contrasena = Hash::make($request->contrasena);
                $aprendiz->correo = $request->correo;
                $perfil->avatar = $request->avatar;
                $perfil->apellido = $request->apellido;
                $perfil->nombre = $request->name;
                $perfil->descripcionPerfil = $request->descripcionPerfil;
                $user->update();
                $perfil->update();
                $aprendiz->update();
                return response()->json(['message' => 'User updated!'], 200);
            } else {
                return response()->json(["error" => "Old password does not match."], 400);
            }
        } else {
            $user->name = $request->name;
            $user->email = $request->correo;
            $aprendiz->correo = $request->correo;
            $perfil->avatar = $request->avatar;
            $perfil->apellido = $request->apellido;
            $perfil->nombre = $request->name;
            $perfil->descripcionPerfil = $request->descripcionPerfil;
            $user->update();
            $perfil->update();
            $aprendiz->update();
            return response()->json(['message' => 'User updated!'], 200);
        }
    }

    /**
     *
     * Actualizar el aprendiz por parte del admin
     */
    public function updateAprendizByAdmin(Request $request, $id)
    {
        $idAdmin = $this->service->obtenerIdAdminAutenticado();

        if (!$idAdmin) {
            return response()->json(["error" => "Usuario no autorizado"], 403);
        }

        $aprendiz = Aprendiz::find($id);
        if (!$aprendiz) {
            return response()->json(["error" => "Aprendiz no encontrado"], 404);
        }

        $aprendiz->ficha_id = $request->ficha_id;
        $aprendiz->tipoDocumento = $request->tipoDocumento;
        $aprendiz->numeroDocumento = $request->numeroDocumento;
        $aprendiz->update();
        return response()->json(["message" => "Aprendiz actualizado"], 200);

    }

    /**
     * 
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Elimina por completo al aprendiz y sus entidades o tablas relacionadas
     */
    public function destroy($id)
    {
        $aprendiz = Aprendiz::find($id);
        Perfil::where('aprendiz_id', $id)->first()->delete();
        if (Aprendiz_has_bono::where('aprendiz_id', $id)->exists()) {
            DB::table("aprendices_has_bonos")->where("aprendiz_id", "=", $id)->delete();
        }
        if (Entrega::where('aprendiz_id', $id)->exists()) {
            $entrega = Entrega::where('aprendiz_id', $id)->get();

            foreach ($entrega as $value) {
                DB::table("material_has_entregas")->where("entrega_id", "=", $value->id)->delete();
                DB::table('entregas')->where("id", "=", $value->id)->delete();
            }
        }
        if (Punto::where('aprendiz_id', $id)->exists()) {
            Punto::where('aprendiz_id', $id)->first()->delete();
        }
        if ($aprendiz) {
            $aprendiz->delete();
            User::where('id', $aprendiz->user_id)->first()->delete();
            return response()->json("Aprendiz con id: " . $id . " eliminado", 200);
        }
        return response()->json(["error" => "Aprendiz no encontrado"], 404);
    }
}
