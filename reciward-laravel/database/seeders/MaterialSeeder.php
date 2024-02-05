<?php

namespace Database\Seeders;

use App\Models\Material;
use Illuminate\Database\Seeder;

class MaterialSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Material::create([
            "nombreMaterial" => "botella 1.5L pepsi",
            "numeroPuntos" => 500,
            "clasificacion_id" => 1
        ]);

        Material::create([
            "nombreMaterial" => "botella aguila lite personal",
            "numeroPuntos" => 1000,
            "clasificacion_id" => 2
        ]);
    }
}
