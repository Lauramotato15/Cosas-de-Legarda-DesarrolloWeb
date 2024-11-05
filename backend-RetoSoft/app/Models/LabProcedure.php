<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LabProcedure extends Model
{
    use HasFactory;
    protected $fillable = [
        'procedure_code',
        'id_lab_group',
        'metodo',
    ];

    public function labGroup()
    {
        return $this->belongsTo(LabGroup::class, 'id_lab_group', 'id_lab_group');
    }

    public function procedureCode(){
        return $this->belongsTo(ProcedureCode::class, 'procedure_code', 'id_lab_procedure');
    }

    public function labTests()
    {
        return $this->hasMany(LabTest::class, 'id_procedure_lab', 'id_lab_procedure');
    }

    public function labOrderResults()
    {
        return $this->hasMany(LabOrderResult::class, 'id_procedure', 'id_lab_procedure');
    }
}
