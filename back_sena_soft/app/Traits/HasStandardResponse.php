<?php

namespace App\Traits;

use Illuminate\Http\Request;


/**
 * Trait HasStandardResponse para retornar una respuesta estandar desde los resources
 * @package App\Traits
 */
trait HasStandardResponse
{
    public function with(Request $request): array
    {
        return [
            'success' => true,
            'message' => 'Exitoso',
        ];
    }
}
