<?php 
namespace App\Repository;

use App\Models\EstudianteMateria;

class EstudianteMateriaRepository extends BaseRepository implements IBaseRepository{
    public function __construct(private EstudianteMateria $model){
        parent::__construct($model);
    }
}