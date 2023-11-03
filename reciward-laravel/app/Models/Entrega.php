<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Entrega extends Model
{
    use HasFactory;
    protected $fillable =["cantidadMaterial", "canjeada", "puntosAcumulados"];
    protected $table = 'entregas';
    public $timestamps = false;
}
