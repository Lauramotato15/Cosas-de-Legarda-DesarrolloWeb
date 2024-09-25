<?php 
namespace App\Service;
/**
 * Interface IBaseService para definir los metodos que se deben implementar en los servicios
 * 
 */
interface IBaseService
{
    public function all();
    public function find($id);
    public function create(array $data);
    public function update(array $data, $id);
    public function delete($id);
}