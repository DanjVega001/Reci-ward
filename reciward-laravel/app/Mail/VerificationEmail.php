<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class VerificationEmail extends Mailable
{
    use Queueable, SerializesModels;

    private $code;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($code)
    {
        $this->code = $code;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $content = "<html>Hola";
        $content .= "Recibes este correo electrónico porque hemos recibido una solicitud de una creación de una cuenta en Reciward.<br>";
        $content .= "Debes digitar el siguiente codigo de 6 digitos para verificar tu cuenta. <br>";
        $content .= "Codigo: <b>".$this->code."</b> <br>";
        $content .= "Si no realizaste esta solicitud, puedes ignorar este correo.</html>";
        return $this
            ->subject('Verificacion del email')
            ->html($content);
    }
}
