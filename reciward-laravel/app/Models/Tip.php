<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tip extends Model
{
    protected $fillable =["nombre_tips", "descripcion", "administrador_id",];
    public $timestamps = false;
    protected $table = "tips";
    use HasFactory;
    
    public function administradores(){
        return $this->belongsTo(Administrador::class,'administrador_id','id');
    }
 
}