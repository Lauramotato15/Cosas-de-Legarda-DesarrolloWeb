<?php 
namespace App\Service;

use App\Repository\IBaseRepository;

class BaseService implements IBaseService {

    /**
     * Constructor e inyeccion del repositorio generico
     * @return void
     * @param \App\Repository\IBaseRepository $repository
     */
    public function __construct(private IBaseRepository $repository){
    }

    /**
     * Metodo para obtener todos los registros
     * @author Laura Motato Moreno
     * @return mixed
     */
    public function all(){
        return $this->repository->all();
    }

    /**
     * Metodo para obtener un registro por id
     * @author Laura Motato Moreno
     * @param int $id
     * @return mixed
     */
    public function find($id){
        return $this->repository->find($id);
    }

    /**
     * Metodo para crear un registro
     * @author Laura Motato Moreno
     * @param array $data
     * @return mixed
     */
    public function create(array $data){
        return $this->repository->create($data);
    }

    /**
     * Metodo para actualizar un registro
     * @author Laura Motato Moreno
     * @param array $data
     * @param int $id
     * @return mixed
     */
    public function update(array $data, $id){
        return $this->repository->update($data, $id);
    }

    /**
     * Metodo para eliminar un registro
     * @author Laura Motato Moreno
     * @param int $id
     * @return mixed
     */
    public function delete($id){
        return $this->repository->delete($id);
    }
}