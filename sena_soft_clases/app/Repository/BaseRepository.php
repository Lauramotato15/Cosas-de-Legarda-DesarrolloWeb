<?php 
namespace App\Repository;

use Illuminate\Database\Eloquent\Model;

abstract class BaseRepository implements IBaseRepository{
    public function __construct(private Model $model){
    }
    public function create(array $data){
        return $this->model->create($data);
    }
    public function update(array $data, $id){
        $model = $this->model->find($id);
        $model?->update($data);
        return $model;
    }
    public function delete($id){
        return $this->model->find($id)->delete();
    }
    public function find($id){
        return $this->model->find($id);
    }
    public function all(){
        return $this->model->all();
    }
}