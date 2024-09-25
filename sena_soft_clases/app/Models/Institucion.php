<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Institucion extends Model
{
    use HasFactory;
    protected $fillable = [           
        'nombre',
        'direccion',
    ];

    function detallesPersonales(){
        return $this->hasMany(DetallePersonal::class);
    }
}
