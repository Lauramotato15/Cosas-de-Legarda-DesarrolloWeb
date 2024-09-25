<?php

namespace App\Http\Controllers;

use App\Http\Mapper\InstitucionResource;
use App\Http\Requests\CreateInstitucionRequest;
use App\Services\InstitucionService;
use Illuminate\Http\Request;

class InstitucionController extends Controller
{
    public function __construct(private InstitucionService $institucionService){    

    }
    public function index(){
        $instituciones = $this->institucionService->all();
        return InstitucionResource::collection($instituciones);
    }

    public function store(CreateInstitucionRequest $request){
        $institucionCreate = $this->institucionService->create($request->all());
        return new InstitucionResource($institucionCreate);
    }

    public function show($id){
        $institucion = $this->institucionService->find($id);
        return new InstitucionResource($institucion);
    }

    public function update(CreateInstitucionRequest $request, $id){
        $institucionUpdate = $this->institucionService->update($request->all(), $id);
        return new InstitucionResource($institucionUpdate);
    }

    public function destroy($id){
        $institucionDelete = $this->institucionService->delete($id);
        return response()->json(['message' => 'Institucion eliminado correctamente']);
    }
}
