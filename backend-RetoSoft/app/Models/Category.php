<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'enabled',
    ];

    public function options()
    {
        return $this->hasMany(CategoryOption::class, 'id_category', 'id_category');
    }
}
