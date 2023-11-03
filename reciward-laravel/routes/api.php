<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\ClasificacionController;
use App\Http\Controllers\API\AdministradorController;
use App\Http\Controllers\API\BonoController;
use App\Http\Controllers\API\FichaController;
use App\Http\Controllers\API\CafeteriaController;
use App\Http\Controllers\API\PerfilController;
use App\Http\Controllers\API\AprendizController;
use App\Http\Controllers\API\MaterialController;
use App\Http\Controllers\API\EntregaController;
use App\Http\Controllers\API\TipController;
use App\Http\Controllers\API\Aprendiz_has_bonoController;
use App\Http\Controllers\API\PuntoController;




/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
Route::apiResource('clasificacion', ClasificacionController::class);

Route::apiResource('admin', AdministradorController::class);

Route::apiResource('bono', BonoController::class);

Route::apiResource('ficha', FichaController::class);

Route::apiResource('cafeteria', CafeteriaController::class);

Route::apiResource('aprendiz', AprendizController::class);

Route::apiResource('material', MaterialController::class);

Route::apiResource('entrega', EntregaController::class);

Route::apiResource('perfil', PerfilController::class);

Route::apiResource('tip', TipController::class);

Route::apiResource('aprendiz_has_bono', Aprendiz_has_bonoController::class);

Route::apiResource('punto', PuntoController::class);

