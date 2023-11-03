<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use APP\Models\Aprendiz;
class Punto extends Model
{
    use HasFactory;

    protected $table = "puntos";
    public $timestamps = false;
    protected $fillable = ["cantidadAcumulada", "puntosUtilizados", "aprendiz_id"];

    public function aprendiz()
    {
        return $this->hasOne(Aprendiz::class, 'aprendiz_id', 'id');
    }
}
