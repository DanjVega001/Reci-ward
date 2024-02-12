<?php

namespace Database\Seeders;

use App\Models\Aprendiz_has_bono;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // User::factory(10)->create();
        $this->call(PermisosRolesSeeder::class);
        $this->call(AdminSeeder::class);
        $this->call(FichaSeeder::class);
        $this->call(AprendizSeeder::class);
        $this->call(MaterialSeeder::class);
        $this->call(CafeteriaSeeder::class);
        $this->call(EntregaSeeder::class);
        $this->call(Material_has_entregaSeeder::class);
        $this->call(BonoSeeder::class);
        $this->call(Aprendiz_has_BonoSeeder::class);
    }
}
