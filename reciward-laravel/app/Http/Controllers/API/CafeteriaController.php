<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Cafeteria;
use App\Models\User;
use Illuminate\Support\Facades\Hash;


class CafeteriaController extends Controller
{
    /**
     * 
     *
     * @return \Illuminate\Http\Response
     * 
     * Muestra la cafetría disponible
     */
    public function index()
    {
        $cafeteria = Cafeteria::all();
        return response()->json($cafeteria, 200);
    }

    /**
     * 
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     * 
     * Crea un nuevo perfil de cafetería
     */
    public function store(Request $request)
    {
        $user = User::create([
            'name' => $request->nombreCafeteria,
            'email' => $request->correoCafeteria,
            'password' => Hash::make($request->contrasenaCafeteria)
        ]);
        $user->assignRole('cafeteria');
        $cafeteria = Cafeteria::create([
            'nombreCafeteria' => $request->nombreCafeteria,
            'correoCafeteria' => $request->correoCafeteria,
            'contrasenaCafeteria' => $user->password,
            'user_id' => $user->id
        ]);
        return response()->json($cafeteria, 201);
    }


     /**
     * .
     *
     * @param  $id 
     * @return \Illuminate\Http\Response
     * 
     * Muestra un perfil de cafetería
     */
    public function show($id){
        $cafeteria = Cafeteria::find($id);
        if ($cafeteria) {
            return response()->json($cafeteria, 200);
        }
        return response()->json(["error"=>"Cafeteria no encontrado"], 404);
    }


    /**
     *
     *
     * @param  $id 
     * @param  \Illuminate\Http\Request
     * @return \Illuminate\Http\Response
     * 
     * Muestra un perfil de cafetería
     */

    public function update(Request $request, $id)
    {
        $cafeteria = Cafeteria::find($id);
        $user = User::find($cafeteria->user_id);
        if ($request->contrasenaAntigua && $request->contrasenaCafeteria) {
            if (Hash::check($request->contrasenaAntigua, $cafeteria->contrasenaCafeteria)) {
                $cafeteria->nombreCafeteria = $request->nombreCafeteria;
                $cafeteria->correoCafeteria = $request->correoCafeteria;
                $cafeteria->contrasenaCafeteria = Hash::make($request->contrasenaCafeteria);
                $user->name = $request->nombreCafeteria;
                $user->email = $request->correoCafeteria;
                $user->password = $cafeteria->contrasenaCafeteria;
                $user->update();
                $cafeteria->update();
                return response()->json($cafeteria, 200);
            } else {
                return response()->json(["error"=>"Las contraseñas no coinciden"], 400);
            }
        } else {
            $cafeteria->nombreCafeteria = $request->nombreCafeteria;
            $cafeteria->correoCafeteria = $request->correoCafeteria;
            $user->name = $request->nombreCafeteria;
            $user->email = $request->correoCafeteria;
            $user->update();
            $cafeteria->update();
            return response()->json($cafeteria, 200);
        }
        
    }



    /**
     * 
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     * 
     * Elimina el perfil de cafetería
     */
    public function destroy($id)
    {
        try {
            $cafeteria = Cafeteria::find($id);
            if ($cafeteria) {
                $cafeteria->delete();
                User::find($cafeteria->user_id)->delete();
                return response()->json("cafeteria con Id " . $id . " eliminado", 200);
            }
            return response()->json(["error" => "cafeteria no encontrada"], 404);
        } catch (\Throwable $th) {
            return response()->json(["error" => $th->getMessage()], 400);
        }
       
    }
}
