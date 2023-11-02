<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Administrador extends Model
{
    protected $fillable =["nombreAdmin", "correoAdmin", "claveAccesoAdmin"];
    public $timestamps = false;
    use HasFactory;
}
