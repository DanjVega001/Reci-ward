<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;

class PermisosRolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // CREAR LOS ROLES
       Role::create(['name' => 'admin']); 
       Role::create(['name' => 'cafeteria']); 
       Role::create(['name' => 'aprendiz']); 
    }
}
