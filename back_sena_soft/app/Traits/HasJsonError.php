<?php

namespace App\Traits;

use Illuminate\Contracts\Validation\Validator;


/**
 * Trait HasJsonError para retornar errores en formato json desde un request
 * @package App\Traits
 */
trait HasJsonError
{
    protected function failedValidation(Validator $validator)
    {
        $response = response()->json([
            'success' => false,
            'errors' => $validator->errors()
        ], 422);

        throw new \Illuminate\Validation\ValidationException($validator, $response);
    }
}
