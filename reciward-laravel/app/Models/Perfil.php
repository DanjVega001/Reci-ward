<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Perfil extends Model
{
    protected $fillable =["apellido", "nombre", "descripcionPerfil", "avatar", "aprendiz_id"];
    public $timestamps = false;
    protected $table = "perfiles";
    use HasFactory;

    
    public function aprendiz(){
        return $this->belongsTo(Aprendiz::class,'aprendiz_id','id');
    }
    
}

