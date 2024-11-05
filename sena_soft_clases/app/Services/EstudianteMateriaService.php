<?php 
namespace App\Services;

use App\Repository\EstudianteMateriaRepository;

class EstudianteMateriaService extends BaseService implements IBaseService{
    public function __construct(private EstudianteMateriaRepository $estudianteMateriaService){
        parent::__construct($estudianteMateriaService);
    }
    public function all(){
        return $this->estudianteMateriaService->all();
    }
    public function create($data){
        return $this->estudianteMateriaService->create($data);
    }
    public function find($id){
        return $this->estudianteMateriaService->find($id);
    }
    public function update($data, $id){
        return $this->estudianteMateriaService->update($data, $id);
    }
    public function delete($id){
        return $this->estudianteMateriaService->delete($id);
    }
}