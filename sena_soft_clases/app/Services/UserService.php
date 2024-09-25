<?php 
namespace App\Services;

use App\Repository\UserRepository;
use Illuminate\Support\Facades\Auth;

class UserService extends BaseService implements IBaseService{
    public function __construct(private UserRepository $userRepository){
        parent::__construct($userRepository);
    }
    public function login($credentials) {
        // Autenticar al usuario y generamos su token
        if (Auth::attempt($credentials)) {
            $user = $this->userRepository->findByEmail($credentials['email']);
            $token =$user->createToken('sena_soft')->plainTextToken;
            return response()->json([
                'token' => $token,
                'user' => $user
            ]);
        } else {
            return response()->json([
                'message' => 'Unauthorized'
            ], 401);
        }
    }
    public function destroyToken($user) {
        // Eliminar el token del usuario autenticado
        if($user == null){
            return response()->json([
                'message' => 'Usuario no autenticado'
            ], 401);
        }
        $user->tokens()->delete();
        return response()->json([
            'message' => 'Token eliminado correctamente'
        ]);
    }
}