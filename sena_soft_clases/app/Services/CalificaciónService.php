<?php 
namespace App\Services;

use App\Repository\CalificacionRepository;

class CalificaciónService extends BaseService implements IBaseService{
    public function __construct(private CalificacionRepository $calificaciónRepository){
        parent::__construct($calificaciónRepository);
    }
}