<?php

namespace App\Http\Mapper;

use App\Traits\HasStandardMapper;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EstudianteMateriasResource extends JsonResource
{
    use HasStandardMapper;
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id_estudiante' => $this->id_estudiante,
            'id_materia' => $this->id_materia,
            'fecha' => $this->fecha,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
