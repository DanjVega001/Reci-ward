<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bono extends Model
{
    use HasFactory;
    protected $fillable =["valorBono", "puntosRequeridos"];
    public $timestamps = false;
}
