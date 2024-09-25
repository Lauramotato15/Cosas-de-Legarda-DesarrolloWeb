<?php

namespace App\Http\Mapper;

use App\Traits\HasStandardMapper;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DetallePersonaResource extends JsonResource
{
    Use HasStandardMapper;
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'documento' => $this->documento,
            'nombre_completo' => $this->nombre_completo,
            'id_institucion' => $this->id_institucion,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
