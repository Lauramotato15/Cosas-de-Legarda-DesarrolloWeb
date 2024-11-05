<?php 
namespace   App\Repositories;

use Illuminate\Database\Eloquent\Model;

class BaseRepository implements IBaseRepository
{
    /**
     * Constructor para inyectar el modelo en el repositorio
     * @author Laura Motato Moreno
     * @param \Illuminate\Database\Eloquent\Model $model, 
     * @return  void
    */

    public function __construct(private Model $model)
    {
        
    }

    /**
     * Método para obtener todos los registros de la tabla
     * @return \Illuminate\Database\Eloquent\Collection
    */
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
        return $this->model->find($id)->update($data);
    }
    public function delete($id)
    {
        return $this->model->find($id)->delete();
    }
    public function getModel()
    {
        return app()->make($this->model());
    }
    public function model()
    {
        return '';
    }
}