<?php 
namespace App\Services;

use App\Repository\IBaseRepository;

class BaseService implements IBaseService{
    public function __construct(private IBaseRepository  $repository){
    }

    public function all(){
        return $this->repository->all();
    }

    public function create(array $data){
        return $this->repository->create($data);
    }

    public function find($id){
        return $this->repository->find($id);
    }

    public function update(array $data, $id){
        return $this->repository->update($data, $id);
    }

    public function delete($id){
        return $this->repository->delete($id);
    }
}