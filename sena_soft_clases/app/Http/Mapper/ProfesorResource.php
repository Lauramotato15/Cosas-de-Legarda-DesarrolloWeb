<?php

namespace App\Http\Mapper;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProfesorResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'id_detalle_personal' => $this->id_detalle_personal,
            'id_materia' => $this->id_materia,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
