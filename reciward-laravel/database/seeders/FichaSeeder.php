<?php

namespace Database\Seeders;

use App\Models\Ficha;
use Illuminate\Database\Seeder;

class FichaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Ficha::create([
            "nombreFicha" => "sistemas",
            "fechaCreacion" =>  "2023-11-03",
            "fechaFin" => "2025-11-03",
            "codigoFicha" => 2557863,
        ]);

    }
}
