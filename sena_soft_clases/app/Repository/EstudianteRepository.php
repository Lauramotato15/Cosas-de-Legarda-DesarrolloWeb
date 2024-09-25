<?php 
namespace App\Repository;

use App\Models\Estudiante;

class EstudianteRepository extends BaseRepository implements IBaseRepository{ 
    public function __construct(private Estudiante $estudiante){ 
        parent::__construct($estudiante); 
    } 
}