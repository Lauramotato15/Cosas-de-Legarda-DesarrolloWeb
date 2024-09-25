<?php

namespace App\Http\Controllers;

use App\Http\Mapper\DetallePersonaResource;
use App\Http\Requests\CreateDetallePersonalRequest;
use App\Services\DetallePersonalService;

class DetallePersonalController extends Controller
{
    public function __construct(private DetallePersonalService $detallePersonalService){

    }
    public function index(){
        $detallesPersonales = $this->detallePersonalService->all();
        return new DetallePersonaResource($detallesPersonales);
    }

    public function store(CreateDetallePersonalRequest $request){
        $detallePersonal = $this->detallePersonalService->create($request->all());
        return new DetallePersonaResource($detallePersonal);
    }

    public function show($id){
        $detallePersonal = $this->detallePersonalService->find($id);
        return new DetallePersonaResource($detallePersonal);
    }

    public function update(CreateDetallePersonalRequest $request, $id){
        $detallePersonal = $this->detallePersonalService->update($request->all(), $id);
        return new DetallePersonaResource($detallePersonal);
    }
    public function destroy($id){
        $this->detallePersonalService->delete($id);
        return response()->json(['message' => 'Detalle Personal eliminado correctamente']);
    }
}