<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:api'])->group(function () {
    Route::get('logout', [AuthController::class, 'logout']);
    Route::apiResource('users', UserController::class);
});

Route::post('login', [AuthController::class, 'login']);
