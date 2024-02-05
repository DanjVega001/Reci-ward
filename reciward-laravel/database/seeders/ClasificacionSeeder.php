<?php

namespace Database\Seeders;

use App\Models\Clasificacion;
use Illuminate\Database\Seeder;

class ClasificacionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Clasificacion::create([
            'nombreClasificacion' => 'Plastico'
        ]);
        Clasificacion::create([
            'nombreClasificacion' => 'Botellas Vidrios'
        ]);
        Clasificacion::create([
            'nombreClasificacion' => 'Carton'
        ]);
    }
}
