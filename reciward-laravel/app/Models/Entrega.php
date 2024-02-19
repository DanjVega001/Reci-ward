<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Entrega extends Model
{
    use HasFactory;
    protected $fillable =["cantidadMaterial", "canjeada", "puntosAcumulados", "cafeteria_id", "aprendiz_id"];
    protected $table = 'entregas';
    public $timestamps = false;

    public function cafeteria(){
        return $this->belongsTo(Cafeteria::class, "cafeteria_id", "id");
    }

    public function aprendiz(){
        return $this->belongsTo(Aprendiz::class, "aprendiz_id", "id");
    }
    /*public function materiales()
    {
        return $this->hasMany(Material_has_entrega::class, 'entrega_id', 'id')
            ->join('materiales', 'material_has_entregas.material_id', '=', 'materiales.id')
            ->select(['materiales.nombreMaterial', 'materiales.numeroMaterial']);
    }*/
}
