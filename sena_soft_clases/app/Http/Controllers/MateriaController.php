<?php

namespace App\Http\Controllers;

use App\Http\Mapper\MateriaResource;
use App\Http\Requests\CreateMateriaRequest;
use App\Services\MateriaService;

class MateriaController extends Controller
{
    public function __construct(private MateriaService $materiaService){

    }

    public function index(){
        $materias = $this->materiaService->all();
        return MateriaResource::collection($materias);
    }

    public function store(CreateMateriaRequest $request){
        $materiaCreate = $this->materiaService->create($request->all());
        return new MateriaResource($materiaCreate);
    }

    public function show($id){
        $materia = $this->materiaService->find($id);
        return new MateriaResource($materia);
    }

    public function update(CreateMateriaRequest $request, $id){
        $materiaUpdate = $this->materiaService->update($request->all(), $id);
        return new MateriaResource($materiaUpdate);
    }
    public function destroy($id){
        $materiaDelete = $this->materiaService->delete($id);
        return response()->json(['message' => 'Materia eliminado correctamente']);
    }
}
