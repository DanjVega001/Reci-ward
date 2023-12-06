<?php

namespace Database\Seeders;

use App\Models\Entrega;
use Illuminate\Database\Seeder;

class EntregaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Entrega::create([
            "cantidadMaterial" => 15,
            "puntosAcumulados" => 2000,
            "cafeteria_id" => 1,
            "aprendiz_id" => 1,
            "canjeada" => false
        ]);

        Entrega::create([
            "cantidadMaterial" => 10,
            "puntosAcumulados" => 1000,
            "cafeteria_id" => 1,
            "aprendiz_id" => 1,
            "canjeada" => false
        ]);
    }
}
