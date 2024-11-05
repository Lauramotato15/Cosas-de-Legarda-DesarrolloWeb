<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LabTest extends Model
{
    use HasFactory;
    protected $fillable = [
        'id_procedure_lab',
        'code_test',
        'name',
        'id_result_type',
        'unit',
        'enabled',
    ];

    public function labProcedure()
    {
        return $this->belongsTo(LabProcedure::class, 'id_procedure_lab', 'id_lab_procedure');
    }

    public function resultType()
    {
        return $this->belongsTo(CategoryOption::class, 'id_result_type', 'id_result_type');
    }

    public function labOptionTests()
    {
        return $this->hasMany(LabOptionTest::class, 'id_test', 'id_lab_test');
    }

    public function labOrderResults()
    {
        return $this->hasMany(LabOrderResult::class, 'id_test', 'id_lab_test');
    }
}
