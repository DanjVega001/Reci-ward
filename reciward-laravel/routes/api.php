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
use App\Models\Aprendiz;

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



/** RUTAS PRINCIPALES PARA PASSPORT */
Route::group([
    'prefix' => 'auth'
], function () {
    Route::post('login', [AuthController::class, "login"]);
    Route::post('signup', [AuthController::class, "signup"]);

    Route::group([
        'middleware' => 'auth:api'
    ], function () {
        Route::get('logout', [AuthController::class, "logout"]);
        Route::get('user', [AuthController::class, "user"]);
    });

    Route::middleware(['auth:api', 'role:admin'])->group(function () {
        // Rutas protegidas para usuarios con el rol "admin".
        Route::apiResource('admin', AdministradorController::class);
        Route::apiResource('ficha', FichaController::class);
        //Route::apiResource('clasificacion', ClasificacionController::class);
        Route::apiResource('bono-admin', BonoController::class);
        //Route::apiResource('cafeteria', CafeteriaController::class);
        //Route::apiResource('aprendiz', AprendizController::class);
        Route::apiResource('material', MaterialController::class);
        Route::apiResource('tip', TipController::class);


        /** RUTAS PERSONALIZADAS */
        /** Entrega 
         *  Muestra el historial de entregas que ha tenido el aprendiz
         */
        Route::get("/entrega/historial-admin/{documento}", [EntregaController::class, 'historialPorAdmin']);
        /** Perfil */
        Route::delete("/perfil/{id}", [PerfilController::class, 'destroy']);
        /** Aprendiz */
        Route::delete("/aprendiz/{id}", [AprendizController::class, 'destroy']);

        
    });

    Route::middleware(['auth:api', 'role:cafeteria'])->group(function () {
        // Rutas protegidas para usuarios con el rol "cafeteria".

        Route::apiResource('bono', BonoController::class);

        

        /** RUTAS PERSONALIZADAS */
        /** Entrega
         * Actos posteriores de la validacion de la entrega del aprendiz
         */
        Route::get("/entrega/validada/{idEntrega}", [EntregaController::class, 'validada']);
        /** Obtiene las entregas del aprendiz especificado */
        Route::get("/entrega/{documento}", [EntregaController::class, 'show']);
        /** Actualiza la entrega en caso de algun cambio */
        Route::put("/entrega/{id}", [EntregaController::class, 'update']);

        /** Bonos 
         * Muestra el bono creado por el aprendiz a traves del codigo validante del bono */
        Route::get("/aprendiz-bono/{codigoValidante}", [Aprendiz_has_bonoController::class, 'show']);
        /** Actualiza el estado del bono cuando el aprendiz lo haya redimido */
        Route::put("/aprendiz-bono/{id}", [Aprendiz_has_bonoController::class, 'update']);

        /** Materiales 
         * Muestra los materiales que tiene la entrega */
        Route::get("/material-entrega/{idEntrega}", [Material_has_entregaController::class, 'show']);
    });

    Route::middleware(['auth:api', 'role:aprendiz'])->group(function () {
        // Rutas protegidas para usuarios con el rol "aprendiz".
        //Route::apiResource('perfil', PerfilController::class);
        /** Perfil 
         * Este metodo devuelve el perfil del aprendiz autenticado */
        Route::get("/perfil/ver", [PerfilController::class,'verPerfil']);
        Route::put("/perfil", [PerfilController::class,'update']);


        /** RUTAS PERSONALIZADAS */
        /** Material
         * Obtener los materiales de reciclaje
         */
        Route::get("/material", [MaterialController::class, 'index']);

        /** Entrega 
         *  Muestra el historial de entregas que ha tenido el aprendiz
         */
        Route::get("/entrega/historial/{id}", [EntregaController::class, 'historialPorApz']);
        
        /** Guarda la entrega del aprendiz */
        Route::post("/entrega", [EntregaController::class, 'store']);
        /** Gaurda los materiales dentro de la entrega */
        Route::post("/material-entrega", [Material_has_entregaController::class, 'store']);
        /** Elimina la entrega del aprendiz */
        Route::delete("/entrega/{id}", [EntregaController::class, 'destroy']);
       
        /** Aprendiz 
         * Actualizar algunos datos, como la contraseña y el correo
        */
        Route::put("/aprendiz/{id}", [AprendizController::class, 'update']);

        /** Bonos 
         * Muestra los bonos no redmidos del aprendiz
        */
        Route::get("/aprendiz-bono", [Aprendiz_has_bonoController::class, 'bonosPorAprendiz']);
        /** Es cuando el aprendiz usa los puntos para obtener un bono */
        Route::post("/aprendiz-bono", [Aprendiz_has_bonoController::class,'store']);
        Route::delete("/aprendiz-bono/{id}", [Aprendiz_has_bonoController::class, 'destroy']);

        /** Puntos 
         * Obtiene los puntos del aprendiz
        */
        Route::get("/punto/ver", [PuntoController::class, 'show']);
    });
});
