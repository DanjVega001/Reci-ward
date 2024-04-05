<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Administrador;
use App\Models\Aprendiz;
use App\Models\Aprendiz_has_bono;
use App\Models\User;
use Spatie\Permission\Models\Role;
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
     * 
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * Crea un usuario con perfil administrador
     */
    public function store(Request $request)
    {
        try {
            $user = User::create([
                'name' => $request->nombreAdmin,
                'email' => $request->correoAdmin,
                'password' => Hash::make($request->contrasenaAdmin)
            ]);
    
            $administrador = Administrador::create([
                'nombreAdmin' => $request->nombreAdmin,
                'correoAdmin' => $request->correoAdmin,
                'contrasenaAdmin' => $user->password,
                'user_id' => $user->id
            ]);


            if (!Role::where('name', 'admin')->exists()) {
                //return  response()->json("NO EXISTE EL ROL", 201);
                Role::create(['name' => 'admin']); 
            }
            //return response()->json("EXISTE EL ROL", 201);

            $user->assignRole('admin');

            return response()->json(["message" => "Admin creado"], 201);
        } catch (\Throwable $th) {
            return response()->json($th->getMessage(), 400);
            
        }
       
    }

    /**
     * 
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
     * 
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Actualiza los datos del usuario con perfil administrador
     */
    public function update(Request $request, $id)
    {
        $administrador = Administrador::find($id);
        $user = User::find($administrador->user_id)->first();
        if (!$administrador) {
            return response()->json(["error"=>"Administrador no encontrado"], 404);
        }
        if ($request->contrasenaAntigua && $request->contrasenaAdmin) {
            if (Hash::check($request->contrasenaAntigua, $administrador->contrasenaAdmin)) {
                $administrador->nombreAdmin = $request->nombreAdmin;
                $administrador->correoAdmin = $request->correoAdmin;
                $administrador->contrasenaAdmin = Hash::make($request->contrasenaAdmin);
                $user->email = $request->correoAdmin;
                $user->name = $request->nombreAdmin;
                $user->password = $administrador->contrasenaAdmin;
                $administrador->update();
                $user->update();
                return response()->json($administrador, 200);
            } else {
                return response()->json(["error"=>"Contraseña antigua incorrecta!"], 400);
            }
        } else {
            $administrador->nombreAdmin = $request->nombreAdmin;
            $administrador->correoAdmin = $request->correoAdmin;
            $user->email = $request->correoAdmin;
            $user->name = $request->nombreAdmin;
            
            $administrador->update();
            $user->update();
            return response()->json($administrador, 200);
        }
        
        
    }

    /**
     * 
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * 
     * Elimina el usuario con perfil administrador
     */
    public function destroy($id)
    {
        $administrador = Administrador::find($id);
        if ($administrador) {
            $administrador->delete();
            User::find($administrador->user_id)->delete();
            return response()->json("Administrador con id: ". $id . " eliminado" , 200);
        }
        return response()->json(["error"=>"Administrador no encontrado"], 404);
    }


    /**
     *  Muestra el historial de bonos del aprendiz por su numero de documento
     *
     */

    public function bonosPorAprendiz($documento)
    {
        
        $aprendiz = Aprendiz::where('numeroDocumento', $documento)->first();
        if (!$aprendiz) {
            return response()->json(['message' => 'Aprendiz no encontrado'], 404);
        }
        $idAprendiz = $aprendiz->id;
        
        $aprendiz_has_bono = Aprendiz_has_bono::where('aprendiz_id', $idAprendiz)
            ->get();

        if ($aprendiz_has_bono===null) {
            return response()->json(['message' => 'El aprendiz no tiene bonos para redimir'], 404);
        }
        $dataBonos = array();
        foreach ($aprendiz_has_bono as $apBono) {
            array_push($dataBonos, [
                'id' => $apBono->id,
                'estadoBono' => $apBono->estadoBono,
                'fechaCreacion' => $apBono->fechaCreacion,
                'fechaVencimiento' => $apBono->fechaVencimiento,
                'codigoValidante' => $apBono->codigoValidante,
                'valorBono' => $apBono->bono->valorBono
            ]);
        }

        $perfil = $aprendiz->perfil;

        return response()->json([
            'nombreAprendiz' => $perfil->nombre,
            'apellidoAprendiz' => $perfil->apellido,
            'documento' => $aprendiz->numeroDocumento,
            'codigoFicha' => $aprendiz->ficha->codigoFicha,
            'bonos' => $dataBonos
        ], 200);
    
        return response()->json($aprendiz_has_bono, 200);
    }
}
