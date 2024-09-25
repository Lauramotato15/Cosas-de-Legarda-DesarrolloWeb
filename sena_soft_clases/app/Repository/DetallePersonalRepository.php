<?php
namespace App\Repository;

use App\Models\DetallePersonal;

class DetallePersonalRepository extends BaseRepository implements IBaseRepository {
    public function __construct(private DetallePersonal $detallePersonal){
        parent::__construct($detallePersonal);
    }
}