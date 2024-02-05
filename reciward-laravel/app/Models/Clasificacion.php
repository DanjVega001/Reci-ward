<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use APP\Models\Material;

class Clasificacion extends Model
{
    protected $fillable =["nombreClasificacion"];
    protected $table = "clasificaciones";
    public $timestamps = false;
    use HasFactory;
    public function materiales()
    {
        return $this->hasMany(Material::class, 'clasificacion_id', 'id');
    }
}
