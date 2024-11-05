<?php

namespace App\Http\Requests;

use App\Traits\HasJsonError;
use Illuminate\Foundation\Http\FormRequest;

class CreateCalificacionesRequest extends FormRequest
{
    use HasJsonError;
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'id_estudiante' => 'required|integer',
            'id_materia' => 'required|integer',
            'puntuacion' => 'required|integer',
        ];
    }
}