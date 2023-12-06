<?php

namespace Database\Seeders;

use App\Models\Aprendiz_has_bono;
use Illuminate\Database\Seeder;

class Aprendiz_has_BonoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        Aprendiz_has_bono::create([
            "codigoValidante" => 123456, 
            "estadoBono" => false, 
            "fechaCreacion" => '2023-12-06', 
            "fechaVencimiento" => '2023-12-15', 
            "aprendiz_id" => 1, 
            "bono_id" => 1, 
            "user_id" => 2
        ]);
    }
}
