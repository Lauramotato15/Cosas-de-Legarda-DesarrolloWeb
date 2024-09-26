<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProcedureCode extends Model
{
    use HasFactory;
    protected $fillable = [
        'code',
        'name',
        'enabled',
    ];

    public function labProcedures()
    {
        return $this->hasMany(LabProcedure::class, 'procedure_code', 'id_procedure_code');
    }
}
