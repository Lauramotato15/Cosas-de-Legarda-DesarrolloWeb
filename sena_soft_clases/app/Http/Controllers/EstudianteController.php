<?php

namespace App\Http\Controllers;

use App\Http\Mapper\EstudianteResource;
use App\Http\Requests\CreateEstudianteRequest;
use App\Services\EstudianteService;
use Illuminate\Http\Request;

class EstudianteController extends Controller
{
    public function __construct(protected EstudianteService $estudianteService){

    }
    public function index(){
        $students = $this->estudianteService->all();
        return EstudianteResource::collection($students);
    }

    public function store(CreateEstudianteRequest $request){
        $newStudent = $this->estudianteService->create($request->all());
        return new EstudianteResource($newStudent);
    }

    public function show($id){
        $studentsFind = $this->estudianteService->find($id);
        return new EstudianteResource($studentsFind);
    }

    public function update(CreateEstudianteRequest $request, $id){
        $studentUpdate = $this->estudianteService->update($request->all(), $id);
        return new EstudianteResource($studentUpdate);
    }

    public function destroy($id){
        $eliminado = $this->estudianteService->delete($id);
        return response()->json(['message' => 'Estudiante eliminado correctamente']);
    }
}
