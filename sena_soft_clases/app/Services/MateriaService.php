<?php 
namespace App\Services;
use App\Repository\MateriaRepository;
class MateriaService extends BaseService implements IBaseService{
    public function __construct(private MateriaRepository $materiaRepository){
        parent::__construct($materiaRepository);
    }
}