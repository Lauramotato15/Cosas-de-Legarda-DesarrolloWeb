<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UserRequest extends FormRequest
{
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
            'id_type_document' => 'required|integer|exists:category_option,id_category_option',
            'document' => 'required|string|max:25',
            'email' => 'required|email|max:50|unique:user,email',
            'name' => 'required|string|max:50',
            'lastname' => 'required|string|max:50',
            'id_sex' => 'required|integer|exists:category_option,id_category_option',
            'phone_number' => 'required|string|max:13',
            'direccion' => 'required|string|max:10',
            'date_of_birth' => 'required|date',
        ];
    }
}
