<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sales extends Model
{
    /** @use HasFactory<\Database\Factories\SalesFactory> */
    use HasFactory;
    protected $fillable = [
        'id_user',
        'total_value',
    ]; 

    public function user(){
        return $this->belongsTo(User::class, 'id_user','id'); 
    }

    public function product(){
        return $this->belongsToMany(Product::class);
    }
}
