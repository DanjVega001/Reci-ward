<?php
namespace App\Service;

use Illuminate\Support\Facades\Auth;

class FuncionesService
{
    public function obtenerIdAprendizAutenticado() {
        
        $user = Auth::user();
        if ($user && $user->aprendiz) {
            return $user->aprendiz->id;
        }

        return null;
    }

    public function obtenerIdAdminAutenticado() {
        $user = Auth::user();
        if ($user && $user->administrador) {
            return $user->administrador->id;
        }
        return null;
    }
}