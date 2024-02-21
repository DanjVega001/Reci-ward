<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class PasswordReset extends Mailable
{
    use Queueable, SerializesModels;

    private $token;

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
        $greeting = '<html> Hola <br>';

        $content = "$greeting <br>";
        $content .= "Recibes este correo electrónico porque hemos recibido una solicitud de restablecimiento de contraseña para tu cuenta.<br>";
        $content .= "Restablecer contraseña con el siguiente codigo: <b> $this->token </b><br>";
        $content .= "Si no realizaste esta solicitud, puedes ignorar este correo.</html>";

        return $this
            ->subject('Restablecer contraseña') // Asunto del correo
            ->html($content); // Contenido del correo
    }
}
