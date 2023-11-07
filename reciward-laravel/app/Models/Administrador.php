<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Administrador extends Model
{
    protected $fillable =["nombreAdmin", "correoAdmin", "contrasenaAdmin", "user_id"];
    protected $table = 'administradores';
    public $timestamps = false;
    use HasFactory;

    public function fichas(){
        return $this->hasMany(Ficha::class,'admin_id','id');
    }

    public function user(){
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
