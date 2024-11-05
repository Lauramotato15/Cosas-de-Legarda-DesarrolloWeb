<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateUserRequest;
use App\Http\Resources\UserResource;
use App\Service\UserService;
use Illuminate\Routing\Controllers\Middleware;

class UserController extends Controller
{
    public function __construct(private UserService $service)
    {
    }

    public function index(){
        $users = $this->service->all();
        return UserResource::collection($users);
    }
    public function store(CreateUserRequest $request){
        $user = $this->service->createUserWithFile($request);
        return new UserResource($user);
    }

    public function update(CreateUserRequest $request, $id){
        $user = $this->service->update($request->all(), $id);
        return new UserResource($user);
    }

    public function destroy($id){
        $userDelete = $this->service->delete($id);
        if($userDelete){
            return response()->json(__('message.user.deleted'), 200);
        }
        return response()->json(null, 204);   
    }

    public function show($id){
        $user = $this->service->find($id);
        return response()->json($user, 200);
    }
}
