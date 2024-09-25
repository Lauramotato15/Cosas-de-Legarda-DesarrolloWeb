<?php
namespace App\Repository;

use App\Models\Calificacion;

class CalificacionRepository extends BaseRepository implements IBaseRepository{
    public function __construct(private Calificacion $calificación){
        parent::__construct($calificación);
    }
}