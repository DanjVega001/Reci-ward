<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use APP\Models\Clasificacion;

class Material extends Model
{
    protected $fillable =["clasificacion_id","nombreMaterial","numeroPuntos" ];
    protected $table = "materiales";
    public $timestamps = false;
    use HasFactory;
    public function clasificacion()
    {
        return $this->belongsTo(Clasificacion::class, 'clasificacion_id', 'id');
    }
}
