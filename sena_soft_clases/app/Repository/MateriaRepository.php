<?php 
namespace App\Repository;

use App\Models\Materia;
class MateriaRepository extends BaseRepository implements IBaseRepository{
    public function __construct(private Materia $materia){
        parent::__construct($materia);
    }
}