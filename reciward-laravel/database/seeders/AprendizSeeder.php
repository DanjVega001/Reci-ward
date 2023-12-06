<?php

namespace Database\Seeders;

use App\Models\Aprendiz;
use App\Models\Perfil;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AprendizSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        $user = User::create([
            'name' => 'Eduardo',
            'email' => 'eduado@gmail.com',
            'password' => Hash::make('123456')
        ]);
        
        $aprendiz = Aprendiz::create([
            'tipoDocumento' => 'CC',
            'numeroDocumento' => 123456,
            'correo' => $user->email,
            'contrasena' => $user->password,
            'user_id' => $user->id,
            'ficha_id' => 1
        ]);
        Perfil::create([
            'apellido' => "Vega",
            'nombre' => $user->name,
            'aprendiz_id' => $aprendiz->id
        ]);
        $user->assignRole('aprendiz');
    }
}
