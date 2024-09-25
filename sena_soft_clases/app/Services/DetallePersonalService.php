<?php 
namespace App\Services;

use App\Repository\DetallePersonalRepository;

class DetallePersonalService extends BaseService implements IBaseService{
    public function __construct(private DetallePersonalRepository $detallePersonalRepository){
        parent::__construct($detallePersonalRepository);
    }
}