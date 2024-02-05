<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cafeteria extends Model
{
    protected $fillable =["nombreCafeteria", "correoCafeteria", "contrasenaCafeteria", "user_id"];
    public $timestamps = false;
    use HasFactory;

    public function entrega(){
        return $this->hasMany(Entrega::class, 'cafeteria_id', 'id');
    }

    public function user(){
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
