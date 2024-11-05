<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Calificacion extends Model
{
    use HasFactory;
    protected $fillable = [
        'id_estudiante', 
        'id_materia', 
        'puntuacion',
    ];

    function materia(){
        return $this->belongsTo(Materia::class);
    }

    function estudiante(){
        return $this->belongsTo(Estudiante::class);
    }
}
