<?php 
namespace App\Repository;

use App\Models\User;

class UserRepository extends BaseRepository implements IBaseRepository {
    public function __construct(private User $user){
        parent::__construct($user);
    }

    public function findByEmail($email){
        return $this->user->where('email', $email)->first();
    }
}