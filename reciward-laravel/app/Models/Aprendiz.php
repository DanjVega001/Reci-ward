<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Aprendiz extends Model
{
    use HasFactory;
    protected $fillable =["tipoDocumento", "numeroDocumento", "contrasena", "correo", "ficha_id", "user_id"];
    protected $table = 'aprendices';
    public $timestamps = false;

    public function ficha(){
        return $this->belongsTo(Ficha::class,'ficha_id','id');
    }

    public function entregas(){
        return $this->hasMany(Entrega::class, 'aprendiz_id', 'id');
    }

    public function perfil(){
        return $this->hasOne(Perfil::class, 'aprendiz_id', 'id');
    }

    public function puntos(){
        return $this->hasOne(Punto::class, 'aprendiz_id', 'id');
    }

    public function user(){
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
