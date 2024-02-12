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
            "nombreMaterial" => "Plastico",
            "numeroPuntos" => 50,
        ]);

        Material::create([
            "nombreMaterial" => "Carton",
            "numeroPuntos" => 30,
        ]);

        Material::create([
            "nombreMaterial" => "Vidrio",
            "numeroPuntos" => 25,
        ]);
    }
}
