<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LabOrder extends Model
{
    use HasFactory;
    protected $fillable = [
        'id_user',
        'professional',
        'orders',
        'date_order',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_user', 'id_order_lab');
    }

    public function labOrderResults()
    {
        return $this->hasMany(LabOrderResult::class, 'id_order', 'id_order_lab');
    }
}
