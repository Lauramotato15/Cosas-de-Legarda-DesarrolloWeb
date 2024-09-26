<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LabOptionTest extends Model
{
    use HasFactory;
    protected $fillable = [
        'id_test',
        'name',
        'value_min_f',
        'value_max_f',
        'value_min_m',
        'value_max_m',
    ];

    public function labTest()
    {
        return $this->belongsTo(LabTest::class, 'id_test', 'id_lab_test');
    }

    public function labOrderResults()
    {
        return $this->hasMany(LabOrderResult::class, 'id_option_test', 'id_options_test_lab');
    }
}
