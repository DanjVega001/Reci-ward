<?php

namespace Database\Seeders;

use App\Models\Administrador;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $user = User::create([
            'name' => 'Daniel Vega',
            'email' => 'daniel@gmail.com',
            'password' => Hash::make('123456')
        ]);

        Administrador::create([
            'nombreAdmin' => $user->name,
            'correoAdmin' => $user->email,
            'contrasenaAdmin' => $user->password,
            'user_id' => $user->id
        ]);
        
        $user->assignRole('admin');

        $user1 = User::create([
            'name' => 'Anderson',
            'email' => 'anderson@gmail.com',
            'password' => Hash::make('123456')
        ]);

        Administrador::create([
            'nombreAdmin' => $user1->name,
            'correoAdmin' => $user1->email,
            'contrasenaAdmin' => $user1->password,
            'user_id' => $user1->id
        ]);
        $user1->assignRole('admin');
    }
}
