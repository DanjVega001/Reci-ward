<?php

namespace Database\Seeders;

use App\Models\Cafeteria;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class CafeteriaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $user = User::create([
            'name' => 'Cafeteria Vega',
            'email' => 'cafe@gmail.com',
            'password' => Hash::make('123456')
        ]);
        
        Cafeteria::create([
            "nombreCafeteria" => $user->name,
            "correoCafeteria" => $user->email,
            "contrasenaCafeteria" => $user->password,
            "user_id" => $user->id
        ]);

        $user->assignRole('cafeteria');        
    }
}
