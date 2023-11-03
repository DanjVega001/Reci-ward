<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Aprendiz extends Model
{
    use HasFactory;
    protected $fillable =["tipoDocumento", "numeroDocumento", "contrasena", "correo", "ficha_id"];
    protected $table = 'aprendices';
    public $timestamps = false;

    public function ficha(){
        return $this->belongsTo(Ficha::class,'ficha_id','id');
    }
}
