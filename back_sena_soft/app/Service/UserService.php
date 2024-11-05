<?php 
namespace App\Service;

use App\Http\Requests\CreateUserRequest;
use App\Repository\UserRepository;
use Illuminate\Support\Facades\Auth;

class UserService extends BaseService implements IBaseService {
    public function __construct(private UserRepository $repository){
        parent::__construct($repository);
    }


    /**
     * Metodo para crear un usuario con una imagen
     * @author laura Motato 
     * @param \App\Http\Requests\CreateUserRequest $request
     * @return mixed
     */
    public function createUserWithFile(CreateUserRequest $request){
        $file = $request->file('photo');
        $fileName = time().'_'.$file->getClientOriginalName();
        $file->move(public_path('uploads'), $fileName);

        $request->merge(['photo' => $fileName]);
        $data = $request->all();
        $data['photo'] = $fileName;
        $createdUser =$this->repository->create($data);
        $createdUser->assignRole($request->role);
        return $createdUser;
    }

    /**
     * Metodo para iniciar sesion'
     * @param array $credentials
     * @return mixed
     */
    public function login($credentials){
        // Autenticar al usuario y generamos su token
        if (Auth::attempt($credentials)) {
            $user = $this->repository->findByEmail($credentials['email']);
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
}