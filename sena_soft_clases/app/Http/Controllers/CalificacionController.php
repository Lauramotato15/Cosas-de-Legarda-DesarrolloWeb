<?php

namespace App\Http\Controllers;

use App\Http\Mapper\CalificacionResource;
use App\Http\Requests\CreateCalificacionesRequest;
use App\Services\CalificaciónService;
use Illuminate\Http\Request;

class CalificacionController extends Controller
{
    public function __construct(private CalificaciónService $calificaciónService){
    }

    public function index(){
        $calificaciones = $this->calificaciónService->all();
        return CalificacionResource::collection($calificaciones);
    }
    public function store(CreateCalificacionesRequest $request){
        $createCalificacion = $this->calificaciónService->create($request->all());      
        return new CalificacionResource($createCalificacion);
    }

    public function show($id){
        $calificacion = $this->calificaciónService->find($id);
        return new CalificacionResource($calificacion);
    }
    public function update(CreateCalificacionesRequest $request, $id){
        $calificacion = $this->calificaciónService->update($request->all(), $id);
        return new CalificacionResource($calificacion); 
    }

    public function destroy($id){
        $eliminado = $this->calificaciónService->find($id);
        return response()->json(['message' => 'Calificación eliminado correctamente']);;
    }
}
