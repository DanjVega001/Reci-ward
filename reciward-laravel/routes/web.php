<?php

use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Laravel\Socialite\Facades\Socialite;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


/** IMPLEMENTACION DE OAUTH DE GOOGLE */

 
Route::get('/login-google', function () {
    return Socialite::driver('google')->redirect();
});
 
Route::get('/google-callback', function () {
    $user = Socialite::driver('google')->user();

    $userExiste = User::where('auth_id', $user->id)->where('auth_name',
        'google')->first();
    if ($userExiste) {
        Auth::login($userExiste);
    } else {
        $nuevoUsuario = User::create([
            'name' => $user->name,
            'email' => $user->email,
            'password' => null,
            'auth_id' => $user->id,
            'auth_name' => 'google'
        ]);
        Auth::login($nuevoUsuario);
    }
    // $user->token
});