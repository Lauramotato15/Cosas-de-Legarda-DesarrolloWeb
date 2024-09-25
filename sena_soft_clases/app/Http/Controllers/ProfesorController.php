<?php

namespace App\Http\Controllers;

use App\Http\Mapper\ProfesorResource;
use App\Services\ProfesorService;
use Illuminate\Http\Request;

class ProfesorController extends Controller
{
    public function __construct(private ProfesorService $profesorService){    

    }
    public function index(){
        $profesores = $this->profesorService->all();
        return ProfesorResource::collection($profesores);
    }
    public function store(Request $request){
        $profesorCreate = $this->profesorService->create($request->all());    
        return new ProfesorResource($profesorCreate);
    }
    public function show($id){
        $profesor = $this->profesorService->find($id);
        return new ProfesorResource($profesor);
    }
    public function update(Request $request, $id){
        $profesorUpdate = $this->profesorService->update($request->all(), $id);
        return new ProfesorResource($profesorUpdate);
    }

    public function destroy($id){
        $profesorDelete = $this->profesorService->delete($id);
        return response()->json(['message' => 'Profesor eliminado correctamente']);
    }
}
