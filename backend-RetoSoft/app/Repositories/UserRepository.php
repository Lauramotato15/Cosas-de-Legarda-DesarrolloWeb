<?php 
namespace App\Repositories;

use App\Models\User;

class UserRepository extends BaseRepository implements IBaseRepository
{
    public function __construct(private User $user){
        parent::__construct($user);
    }
    
    public function findByBirthdateAndDocumentTypeAndDocument($dateBirth, $document, $typeDocument){
       return $this->user->where("date_of_birth", $dateBirth)
       ->where("document", $document)
       ->where("id_type_document",$typeDocument)->first();
    }

    public function findByDocument($document){
        return $this->user->where('document', $document)->first();
    }
}