<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Material_has_entrega extends Model
{
    use HasFactory;

    protected $fillable =["material_id", "entrega_id", "numeroMaterial"];
    protected $table = "material_has_entregas";
    public $timestamps = false;

    public function material(){
        return $this->belongsTo(Material::class, "material_id", "id");
    }

    public function entrega(){
        return $this->belongsTo(Entrega::class, "entrega_id", "id");
    }
}
