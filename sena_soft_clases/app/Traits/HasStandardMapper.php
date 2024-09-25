<?php
namespace App\Traits;

trait HasStandardMapper
{
    public function with($request)
    {
        return [
            'message' => 'true',
            'status' => 'success'
        ];
    }
}