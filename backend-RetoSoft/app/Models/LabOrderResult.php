<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LabOrderResult extends Model
{
    use HasFactory;
    protected $fillable = [
        'date_result',
        'id_order',
        'id_procedure',
        'id_test',
        'id_option_test',
        'option_result',
        'number_result',
        'text_result',
        'memo_result',
        'num_processings',
    ];

    public function labOrder()
    {
        return $this->belongsTo(LabOrder::class, 'id_order', 'id_order_lab');
    }

    public function labProcedure()
    {
        return $this->belongsTo(LabProcedure::class, 'id_procedure', 'id_lab_procedure');
    }

    public function labTest()
    {
        return $this->belongsTo(LabTest::class, 'id_test', 'id_lab_test');
    }

    public function labOptionTest()
    {
        return $this->belongsTo(LabOptionTest::class, 'id_option_test', 'id_options_test_lab');
    }
}
