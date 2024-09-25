<?php 
namespace App\Services;

use App\Repository\InstitucionRepository;

class InstitucionService extends BaseService implements IBaseService{
    public function __construct(private InstitucionRepository $institucionRepository){
        parent::__construct($institucionRepository);
    }
}