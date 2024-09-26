<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use App\Services\UserService;

class AuthController extends Controller
{
    /**
     * Summary of __construct
     * @param \App\Services\UserService $service
     * @return void
     * @author Laura Caterin Motato
    */

    public function __construct(private UserService $service)
    {
    }

    /**
     * Metodo para iniciar sesion
     * @author Laura Motato Moreno
     * @param \App\Http\Requests\LoginRequest $request
     * @return mixed|\Illuminate\Http\JsonResponse
    */
    public function login(LoginRequest $request){
        $credentials = $request->all();
        return $this->service->login($credentials);
    }

    public function logout(){
        return $this->service->logout();
    }
}
