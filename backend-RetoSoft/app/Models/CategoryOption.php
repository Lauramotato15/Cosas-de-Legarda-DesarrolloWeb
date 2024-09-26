<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CategoryOption extends Model
{
    use HasFactory;
    protected $fillable = [
        'id_category',
        'abbreviation',
        'name',
        'enabled',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'id_category', 'id_category');
    }

    public function users()
    {
        return $this->hasMany(User::class, 'id_type_document', 'id_category_option');
    }

    public function usersSexs()
    {
        return $this->hasMany(User::class, 'id_sex', 'id_category_option');
    }

    public function labTests()
    {
        return $this->hasMany(LabTest::class, 'id_result_type', 'id_category_option');
    }
}
