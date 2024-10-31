<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SalesDetails extends Model
{
    /** @use HasFactory<\Database\Factories\SalesDetailsFactory> */
    use HasFactory;
    protected $fillable = [
        'quantity',
        'total_value', 
        'id_product', 
        'id_sale', 
    ];

} 
