<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use APP\Models\Aprendiz;
use APP\Models\Bono;

class Aprendiz_has_bono extends Model
{
    use HasFactory;
    protected $fillable = ["codigoValidante", "estadoBono","fechaCreacion", "fechaVencimiento"];
    protected $table = "aprendices_has_bonos";
    public $timestamps = false;

    public function aprendiz(){
        return $this->belongsTo(Aprendiz::class,"aprendiz_id","id");
    }
    public function bono(){
        return $this->belongsTo(Bono::class,"bono_id","id");
    }
}
