<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//ApiResource para que cada controlador tenga las rutas de los métodos CRUD
//middleware para que las rutas solo sean accesibles por usuarios autenticados
Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('users', 'App\Http\Controllers\AuthController');
    Route::apiResource('detalle_personals', 'App\Http\Controllers\DetallePersonalController');
    Route::apiResource('institucions', 'App\Http\Controllers\InstitucionController');
    Route::apiResource('materias', 'App\Http\Controllers\MateriaController');
    Route::apiResource('profesors', 'App\Http\Controllers\ProfesorController');
    Route::apiResource('estudiantes', 'App\Http\Controllers\EstudianteController');
});

//Rutas para autenticación
Route::post('login', 'App\Http\Controllers\AuthController@login');
