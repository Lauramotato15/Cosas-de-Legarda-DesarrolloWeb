<?php

namespace App\Http\Mapper;

use App\Traits\HasStandardMapper;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EstudianteResource extends JsonResource
{
    use HasStandardMapper;
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return[
            'id' => $this->id,
            'numero_salon' => $this->numero_salon,
            'id_detalle_personal' => $this->id_detalle_personal,
            'detalle_personal' => new DetallePersonaResource($this->detallePersonal),
        ];
    }
}
