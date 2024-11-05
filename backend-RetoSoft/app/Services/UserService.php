<?php
namespace App\Services;

use App\Repositories\UserRepository;
use Tymon\JWTAuth\Facades\JWTAuth;

class UserService extends BaseService implements IBaseService
{
    /**
     * Summary of __construct
     * @param \App\Repositories\UserRepository $repository
     * @return void
     * @author Laura Motato Moreno
    */
    public function __construct(private UserRepository $repository)
    {
        parent::__construct($repository);
    }

    /**
     * Método para obtener cada valor del request validar las credenciales del usuario,
     * generar el token y retornar un json con la informacion del usuario o con el mensaje de error
     * @author Laura Motato Moreno
     * @param array $request un arreglo que contiene las credenciales del usuario
     * @return \Illuminate\Http\JsonResponse|mixed
    */

    public function login($request){
        $dateBirth = $request["date_of_birth"];
        $document = $request["document"];
        $typeDocument = $request["document_type"];
    
        $userAuth = $this->repository->findByBirthdateAndDocumentTypeAndDocument($dateBirth, $document, $typeDocument);
        if ($userAuth) {
            $user = $this->repository->findByDocument($request['document']);
            $token = JWTAuth::fromUser($user);
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

    public function logout(){
        JWTAuth::invalidate(JWTAuth::getToken());
        return response()->json([
            'message' => 'Logout success'
        ]);
    }
}