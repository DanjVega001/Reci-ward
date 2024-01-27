<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Mail\PasswordReset;
use App\Models\Aprendiz;
use App\Models\Perfil;
use Illuminate\Support\Str;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;

class AuthController extends Controller
{
    /**
     * Registro de usuario
     */
    public function signUp(Request $request)
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password)
        ]);

        $aprendiz = Aprendiz::create([
            'tipoDocumento' => $request->tipoDocumento,
            'numeroDocumento' => $request->numeroDocumento,
            'correo' => $request->email,
            'contrasena' => Hash::make($request->password),
            'user_id' => $user->id,
            'ficha_id' => $request->ficha_id
        ]);
        Perfil::create([
            'apellido' => $request->apellido,
            'nombre' => $request->name,
            'aprendiz_id' => $aprendiz->id
        ]);
        $user->assignRole('aprendiz');

        return response()->json([
            'message' => 'Successfully created user!'
        ], 201);
    }

    /**
     * Inicio de sesión y creación de token
     */
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
            'remember_me' => 'boolean'
        ]);

        $credentials = request(['email', 'password']);

        if (!Auth::attempt($credentials))
            return response()->json([
                'message' => 'Unauthorized'
            ], 401);

        $user = $request->user();
        $tokenResult = $user->createToken('Personal Access Token');

        $token = $tokenResult->token;
        if ($request->remember_me)
            $token->expires_at = Carbon::now()->addWeeks(1);
        $token->save();

        if (!$user->aprendiz) {
            return response()->json([
                'id' => $user->id,
                'access_token' => $tokenResult->accessToken,
                'name' => $user->name,
                'email' => $user->email,
                'token_type' => 'Bearer',
                'expires_at' => Carbon::parse($token->expires_at)->toDateTimeString()
            ]);
        }

        return response()->json([
            'id' => $user->id,
            'access_token' => $tokenResult->accessToken,
            'name' => $user->name,
            'email' => $user->email,
            'aprendiz' => $user->aprendiz,
            'perfil' => $user->aprendiz->perfil,
            'ficha' => $user->aprendiz->ficha,
            'token_type' => 'Bearer',
            'expires_at' => Carbon::parse($token->expires_at)->toDateTimeString()
        ]);
    }

    /**
     * Cierre de sesión (anular el token)
     */
    public function logout(Request $request)
    {
        $request->user()->token()->revoke();

        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }

    /**
     * Obtener el objeto User como json
     */
    public function user(Request $request)
    {
        $user = Auth::user();

        $rol = null;
        if ($user->aprendiz) {
            $rol = "aprendiz";
        } elseif ($user->administrador) {
            $rol = "admin";
        } else {
            $rol = "cafeteria";
        }
        return response()->json([
            "user" => $request->user(),
            "rol" => $rol
        ]);
    }

    /**
     * Metodo que maneja el envio del correo para restablecer la contraseña
     */
    public function enviarRecuperarContrasena(Request $request)
    {
        $request->validate([
            'email' => 'required',
        ]);
        $email = $request->email;
        if (!$email) return response()->json(['error' => 'Proporcion un email valido']);

        $cuentaExiste = User::where('email', $email)->exists();

        if (!$cuentaExiste) return response()->json(['error' => 'Cuenta no existe']);

        $token = null;
        $unico = false;
        while (!$unico) {
            $token = Str::random(6);
            $existeToken = DB::table('password_resets')->where(
                'token',
                $token
            )->exists();
            if (!$existeToken) {
                $unico = true;
            }
        }

        // Eliminamos la anterior reseteo de contraseña sin terminar
        DB::table('password_resets')->where(['email' => $email])->delete();

        // Creamos la solicitud de reseteo de contraseña
        DB::table('password_resets')->insert([
            'email' => $email,
            'token' => $token,
            'created_at' => Carbon::now()
        ]);

        // Se envia el correo electrónico
        Mail::to($email)->send(new PasswordReset($token));

        return response()->json(['message' => 'Te hemos enviado un email con las instrucciones para que recuperes tu contraseña'], 200);
    }

    /**
     * Metodo para restablecer la contraseña
     */

    public function resetPassword(Request $request)
    {
        $request->validate([
            'password' => 'required',
            'token' => 'required',
        ]);

        try {
            $email = DB::table('password_resets')->where(['token' => $request->token])->first()->email;
            $user = User::where('email', $email)->first();

            $aprendiz = $user->aprendiz;

            $user->password = Hash::make($request->password);
            $aprendiz->contrasena = $user->password;
            $user->update();
            $aprendiz->update();

            return response()->json(['message' => 'contraseña restablecida correctamente']);
        } catch (\Throwable $th) {
            return response()->json(['error' => 'Error al restablecer la contraseña'], 200);
        }
    }
}
