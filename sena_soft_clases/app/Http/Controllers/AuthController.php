<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateUserRequest;
use App\Http\Mapper\UserResource;
use App\Models\User;
use App\Services\UserService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller {
    public function __construct(private UserService $userService){

    }

    public function store(CreateUserRequest $request){
        $userCreate = $this->userService->create($request->all());
        return new UserResource($userCreate);
    }

    public function index(){
        $users = $this->userService->all();
        return UserResource::collection($users);
    }

    public function show($id){
        $user = $this->userService->find($id);
        return new UserResource($user);
    }     

    public function  update(CreateUserRequest $request, $id){
        $userUpdate = $this->userService->update($request->all(), $id);
        return new UserResource($userUpdate);
    }

    public function destroy($id){
        $userDelete = $this->userService->delete($id);
        return response()->json(['message' => 'Usuario eliminado correctamente']);
    }
    public function login(Request $request){
        $credencials = $request->only('email', 'password');
        return $this->userService->login($credencials);
    }

    public function logout(){
        $user = Auth::user();
        return $this->userService->destroyToken($user);
    }
}
