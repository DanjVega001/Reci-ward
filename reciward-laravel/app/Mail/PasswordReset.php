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
        $url = "http://reciward/password-reset/?token=".$this->token;
        $greeting = '<html>Hola';

        $content = "$greeting <br>";
        $content .= "Recibes este correo electrónico porque hemos recibido una solicitud de restablecimiento de contraseña para tu cuenta.<br>";
        $content .= "Restablecer contraseña:<a href='$url'> <b>Restablecer contraseña</b></a> <br>";
        $content .= "Si no realizaste esta solicitud, puedes ignorar este correo.</html>";

        return $this
            ->subject('Restablecer contraseña') // Asunto del correo
            ->html($content); // Contenido del correo
    }
}
