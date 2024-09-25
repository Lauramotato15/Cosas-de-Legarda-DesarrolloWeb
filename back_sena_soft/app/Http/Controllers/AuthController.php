<?php

namespace App\Http\Controllers;

use App\Service\UserService;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    /**
     * Constructor e inyection del servicio de usuario
     * @return void
     * @author Laura Motato Moreno
     * @param \App\Service\UserService $service
     */
    public function __construct(private UserService $service)
    {

    }

    /**
     * Metodo para iniciar sesion
     * @author Laura Motato Moreno
     * @param \Illuminate\Http\Request $request
     * @return mixed|\Illuminate\Http\JsonResponse
     */
    public function login(Request $request){
        $credentials = $request->only('email', 'password');
        return $this->service->login($credentials);
    }
}
