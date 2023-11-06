<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ficha extends Model
{
    protected $fillable =["nombreFicha", "codigoFicha", "fechaCreacion", "fechaFin", "admin_id"];
    public $timestamps = false;
    use HasFactory;

    
    public function admin(){
        return $this->belongsTo(Administrador::class,'admin_id','id');
    }

    public function aprendices(){
        return $this->hasMany(Aprendiz::class,'ficha_id','id');
    }
    
}
