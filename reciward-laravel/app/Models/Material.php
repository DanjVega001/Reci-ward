<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Material extends Model
{
    protected $fillable =["nombreMaterial","numeroPuntos" ];
    protected $table = "materiales";
    public $timestamps = false;
    use HasFactory;
    public function clasificacion()
    {
        return $this->belongsTo(Clasificacion::class, 'id');
    }
}
