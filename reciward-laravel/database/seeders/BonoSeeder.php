<?php

namespace Database\Seeders;

use App\Models\Bono;
use Illuminate\Database\Seeder;

class BonoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Bono::create([
            "valorBono" => 2500,
            "puntosRequeridos" => 1000
        ]);
    }
}
