<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Administrador extends Model
{
    protected $fillable =["nombreAdmin", "correoAdmin", "contrasenaAdmin"];
    protected $table = 'administradores';
    public $timestamps = false;
    use HasFactory;
}
