<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Profesor extends Model
{
    use HasFactory;
    protected $fillable = [                
        'id_detalle_personal',
        'id_materia',
    ];

    function materia(){
        return $this->belongsTo(Materia::class);
    }

    function detallePersonal(){
        return $this->belongsTo(DetallePersonal::class);
    }
}
