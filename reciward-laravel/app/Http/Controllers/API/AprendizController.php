<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Aprendiz;
use App\Models\Ficha;
use Illuminate\Support\Facades\Hash;

class AprendizController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        $aprendices = Aprendiz::all();
        return response()->json($aprendices, 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $ficha_id = Ficha::where('codigoFicha', $request->codigo_ficha)->first()->id;

        $aprendices = Aprendiz::create([
            'tipoDocumento' => $request->tipoDocumento,
            'numeroDocumento' => $request->numeroDocumento,
            'correo' => $request->correo,
            'contrasena' => Hash::make($request->contrasena),
            'ficha_id' => $ficha_id,
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
        $aprendiz = Aprendiz::find($id);
        if ($aprendiz) {
            return response()->json($aprendiz, 200);
        }
        return response()->json(["error"=>"Aprendiz no encontrado"], 404);
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
        $aprendiz = Aprendiz::find($id);
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
