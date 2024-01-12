<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class PasswordReset extends Mailable
{
    use Queueable, SerializesModels;

    private String $token;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($token)
    {
        $this->token = $token;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        // Cambiar url
        $url = ".../reset-password";
        return $this
        ->subject('Restablecer contraseña') // Asunto del correo
        ->greeting('Hola') // Saludo
        ->line('Recibes este correo electrónico porque hemos recibido una solicitud de restablecimiento de contraseña para tu cuenta.') // Cuerpo del correo
        ->action('Restablecer contraseña', $url) // Botón con el enlace
        ->line('Si no realizaste esta solicitud, puedes ignorar este correo.') // Información adicional
        ->salutation('Saludos'); // Despedida
    }
}
