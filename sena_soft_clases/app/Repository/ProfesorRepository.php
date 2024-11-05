<?php 
namespace App\Repository;

use App\Models\Profesor;

class ProfesorRepository extends BaseRepository implements IBaseRepository{ 
    public function __construct(private Profesor $profesor){ 
        parent::__construct($profesor); 
    } 
}