<?php

namespace App\Http\Mapper;

use App\Traits\HasStandardMapper;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class InstitucionResource extends JsonResource
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
            'nombre' => $this->nombre,
            'direccion' => $this->direccion,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
