<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Mailjet\Response;

class PasswordReset extends BaseEmail
{
    use Queueable, SerializesModels;

    private $token;

    protected $email;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($token, $email)
    {
        $this->token = $token;
        $this->email = $email;
    }

    protected function generateHtml(): void
    {

        $greeting = '<html> Hola <br>';

        $content = "$greeting <br>";
        $content .= "Recibes este correo electrónico porque hemos recibido una solicitud de restablecimiento de contraseña para tu cuenta.<br>";
        $content .= "Restablecer contraseña con el siguiente codigo: <b> $this->token </b><br>";
        $content .= "Si no realizaste esta solicitud, puedes ignorar este correo.</html>";
        $this->html = $content;
    }

    protected function generateSubject(string $subject): void
    {
        $this->subject = $subject;
    }

    public function build() : Response
    {
        $this->generateMailjetClient();
        $this->generateHtml();
        $this->generateSubject('Recuperación de contraseña en ' . config('app.name'));
        return $this->sendEmail();
    }
}
