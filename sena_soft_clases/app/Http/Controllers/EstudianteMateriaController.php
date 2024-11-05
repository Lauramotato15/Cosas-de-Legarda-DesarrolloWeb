<?php

namespace App\Http\Controllers;

use App\Services\EstudianteMateriaService;
use Illuminate\Http\Request;

class EstudianteMateriaController extends Controller
{
   public function __construct(private EstudianteMateriaService $estudianteMateriaService){    

    }
    public function index(){
        $estudianteMaterias = $this->estudianteMateriaService->all();
        return response()->json($estudianteMaterias);
    }
    public function store(Request $request){
        $estudianteMateriaCreate = $this->estudianteMateriaService->create($request->all());    
        return response()->json($estudianteMateriaCreate);
    }
    public function show($id){
        $estudianteMateria = $this->estudianteMateriaService->find($id);
        return response()->json($estudianteMateria);
    }
    public function update(Request $request, $id){
        $estudianteMateriaUpdate = $this->estudianteMateriaService->update($request->all(), $id);
        return response()->json($estudianteMateriaUpdate);
    }

    public function destroy($id){
        $estudianteMateriaDelete = $this->estudianteMateriaService->delete($id);
        return response()->json(['message' => 'Estudiante materia eliminado correctamente']);

   }
}
