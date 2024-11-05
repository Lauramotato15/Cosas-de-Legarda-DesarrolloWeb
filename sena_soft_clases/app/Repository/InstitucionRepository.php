<?php 
namespace App\Repository;

use App\Models\Institucion;

class InstitucionRepository extends BaseRepository implements IBaseRepository{
    public function __construct(private Institucion $institucion){
        parent::__construct($institucion);
    }
}