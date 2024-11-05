<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetallePersonal extends Model
{
    use HasFactory;
    protected $guarded = ['documento'];
    protected $fillable = [                
        'nombre_completo',
        'id_institucion',
    ];

    function institucion(){
        return $this->belongsTo(Institucion::class); 
    }

    function profesores(){
        return $this->hasMany(Profesor::class); 
    }

    function estudiantes(){
        return $this->hasMany(Estudiante::class);
    }
}
