<?php 
namespace App\Services;
use App\Models\LabOrder;
use App\Repositories\BaseRepository;
use App\Repositories\IBaseRepository;

class LabOrderRepository extends BaseRepository implements IBaseRepository{
    public function __construct(private LabOrder $model){
        parent::__construct($model);
    }

    public function findOrderNumber($orderNumber){
        return $this->model->where('order_number', $orderNumber)->first();
    }
}