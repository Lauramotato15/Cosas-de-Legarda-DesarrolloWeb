<?php 
namespace App\Repository;

use Illuminate\Database\Eloquent\Model;

class BaseRepository implements IBaseRepository
{
    public function __construct(private Model $model)
    {

    }
    public function all()
    {
        return $this->model->all();
    }
    public function find($id)
    {
        return $this->model->find($id);
    }
    public function create(array $data)
    {
        return $this->model->create($data);
    }
    public function update(array $data, $id)
    {
        $record = $this->model->find($id);
        $record?->update($data);
        return $record;
    }
    public function delete($id)
    {
        return $this->model->where("id", $id)->delete();
    }
}