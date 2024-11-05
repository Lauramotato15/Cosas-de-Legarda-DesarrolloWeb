<?php

namespace App\Http\Mapper;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CalificacionResource extends JsonResource
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
            'id_estudiante' => $this->id_estudiante,
            'id_materia' => $this->id_materia, 
            'puntuacion' => $this->puntuacion,
        ];
    }
}
