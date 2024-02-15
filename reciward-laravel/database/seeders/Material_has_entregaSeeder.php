<?php

namespace Database\Seeders;

use App\Models\Material_has_entrega;
use Illuminate\Database\Seeder;

class Material_has_entregaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Material_has_entrega::create([
            "material_id" => 2,
            "entrega_id" => 1,
            "numeroMaterial" => 5
        ]);

        Material_has_entrega::create([
            "material_id" => 1,
            "entrega_id" => 1,
            "numeroMaterial" => 2
        ]);

        Material_has_entrega::create([
            "material_id" => 2,
            "entrega_id" => 2,
            "numeroMaterial" => 3
        ]);

        Material_has_entrega::create([
            "material_id" => 1,
            "entrega_id" => 2,
            "numeroMaterial" => 4
        ]);
    }
}
