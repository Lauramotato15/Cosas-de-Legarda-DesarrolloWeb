<?php

namespace App\Http\Resources;

use App\Traits\HasStandardResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    use HasStandardResponse;
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'email' => $this->email,
            'photo' => $this->photo,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
