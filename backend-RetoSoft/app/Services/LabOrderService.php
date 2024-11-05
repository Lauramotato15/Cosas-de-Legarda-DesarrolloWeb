<?php 
namespace App\Services;
class LabOrderService extends BaseService implements IBaseService{
    public function __construct(private LabOrderRepository $repository){
        parent::__construct($repository);
    }
    public function create($data){
        $labOrder = $this->repository->create($data);
        return $labOrder;
    }
    public function update($id, $data){
        $labOrder = $this->repository->update($id, $data);
        return $labOrder;
    }
    public function delete($id){
        $labOrder = $this->repository->delete($id);
        return $labOrder;
    }
    public function all(){
        $labOrders = $this->repository->all();
        return $labOrders;
    }
    public function find($id){
        $labOrder = $this->repository->find($id);
        return $labOrder;
    }

    public function findOrderNumber($orderNumber){
        return $this->repository->findOrderNumber($orderNumber);
    }
}