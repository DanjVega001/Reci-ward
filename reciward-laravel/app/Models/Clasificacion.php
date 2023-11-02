<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Clasificacion extends Model
{
    protected $fillable =["nombreClasificacion"];
    protected $table = "clasificaciones";
    public $timestamps = false;
    use HasFactory;
}
