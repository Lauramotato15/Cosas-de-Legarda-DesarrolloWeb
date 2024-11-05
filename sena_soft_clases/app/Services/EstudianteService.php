<?php
namespace  App\Services;

use App\Repository\EstudianteRepository;

class EstudianteService extends BaseService implements IBaseService{
    public function __construct(private EstudianteRepository $estudianteRepository){
        parent::__construct($estudianteRepository);
    }
}