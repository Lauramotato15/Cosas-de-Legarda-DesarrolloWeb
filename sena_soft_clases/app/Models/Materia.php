<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Materia extends Model
{
    use HasFactory;
    protected $fillable = [
        'nombre',
        'duracion',
    ];

    function profesores(){
        return $this->hasMany(Profesor::class);
    }

    function calificaciones(){
        return $this->belongsTo(Calificacion::class);
    }

    function estudiantes(){
        return $this->belongsToMany(Estudiante::class);
    }
}
