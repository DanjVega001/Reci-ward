<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tip extends Model
{
    protected $fillable =["nombreTips", "descripcionTips", "tip_id", "admin_id", "aprendiz_id"];
    public $timestamps = false;
    protected $table = "tips";
    use HasFactory;
    
    public function administradores(){
        return $this->belongsTo(Admin::class,'admin_id','id');
    }
    public function aprendices(){
        return $this->belongsTo(Aprendiz::class,'aprendiz_id','id');
    }  
}