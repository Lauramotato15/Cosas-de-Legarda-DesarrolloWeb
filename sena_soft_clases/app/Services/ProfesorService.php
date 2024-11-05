<?php 
namespace App\Services;

use App\Repository\ProfesorRepository;

class ProfesorService extends BaseService implements IBaseService{
    public function __construct(private ProfesorRepository $profesorRepository){
        parent::__construct($profesorRepository);
    }
}