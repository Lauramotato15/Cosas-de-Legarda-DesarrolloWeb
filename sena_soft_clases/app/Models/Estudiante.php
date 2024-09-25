<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Estudiante extends Model
{
    use HasFactory;
    protected $fillable = [
        'name', 
        'numero_salon', 
        'id_detalle_personal'
    ];
    
    function  detallePersonal(){
        return $this->belongsTo(DetallePersonal::class,'id_detalle_personal','documento');
    }

    function materias(){
        return $this->belongsToMany(Materia::class);
    }
}
