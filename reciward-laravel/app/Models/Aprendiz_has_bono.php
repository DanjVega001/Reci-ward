<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Aprendiz;
use App\Models\Bono;

class Aprendiz_has_bono extends Model
{
    use HasFactory;
    protected $fillable = ["codigoValidante", "estadoBono","fechaCreacion", "fechaVencimiento", 
        "aprendiz_id", "bono_id", "user_id"];
    protected $table = "aprendices_has_bonos";
    public $timestamps = false;

    public function aprendiz(){
        return $this->belongsTo(Aprendiz::class,"aprendiz_id","id");
    }
    public function bono(){
        return $this->belongsTo(Bono::class,"bono_id","id");
    }
}
