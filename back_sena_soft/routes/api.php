<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum'])->group(function () {
    Route::group(['prefix'=> 'user'], function () {

        Route::get('/', [UserController::class,'index'])->name('user.index')->middleware('permission:ver usuario');
        Route::post('/', [UserController::class,'store'])->name('user.store')->middleware('permission:crear usuario');
        Route::put('{id}', [UserController::class,''])->name('user.update')->middleware('permission:editar usuario');
        Route::delete('{id}', [UserController::class,'destroy'])->name('user.destroy')->middleware('permission:eliminar usuario');
    });
});


Route::post('login', [AuthController::class, 'login']);