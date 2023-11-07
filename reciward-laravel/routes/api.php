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
use App\Http\Controllers\API\Material_has_entregaController;
use App\Http\Controllers\API\PuntoController;
use App\Http\Controllers\API\AuthController;
use App\Http\Middleware\CheckUserType;

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


Route::apiResource('admin', AdministradorController::class);

Route::apiResource('bono', BonoController::class);



Route::apiResource('cafeteria', CafeteriaController::class);

Route::apiResource('aprendiz', AprendizController::class);

Route::apiResource('material', MaterialController::class);

Route::apiResource('entrega', EntregaController::class);

Route::apiResource('perfil', PerfilController::class);

Route::apiResource('tip', TipController::class);

Route::apiResource('aprendiz-bono', Aprendiz_has_bonoController::class);

Route::apiResource('punto', PuntoController::class);

Route::apiResource('material-entrega', Material_has_entregaController::class);


/** RUTAS PERSONALIZADAS */

/** Entrega 
 *  Muestra el historial de entregas que ha tenido el aprendiz
*/
Route::get("/entrega/historial/{documento}", [EntregaController::class, 'historial']);

/** Actos posteriores de la validacion de la entrega del aprendiz*/
Route::get("/entrega/validada/{idEntrega}", [EntregaController::class, 'validada']);

/** Api que devuelve los bonos de un apreindiz que no han sido redimidos */
Route::get("/aprendiz-bono/bonos/{idAprendiz}", [Aprendiz_has_bonoController::class, 'bonosPorAprendiz']);


/** RUTAS PRINCIPALES PARA PASSPORT */
Route::group([
    'prefix' => 'auth'
], function () {
    Route::post('login', [AuthController::class, "login"]);
    Route::post('signup', [AuthController::class, "signup"]);
  
    Route::group([
      'middleware' => 'auth:api'
    ], function() {
        Route::get('logout', [AuthController::class, "logout"]);
        Route::get('user', [AuthController::class, "user"]);
    });

    Route::middleware(['auth:api', 'role:admin'])->group(function () {
        // Rutas protegidas para usuarios con el rol "admin".
        Route::apiResource('ficha', FichaController::class);
        Route::apiResource('clasificacion', ClasificacionController::class);
    });
});



