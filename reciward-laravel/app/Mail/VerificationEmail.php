<?php

namespace App\Mail;

use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Mailjet\Response;

class VerificationEmail extends BaseEmail
{
    protected $email;
    private $code;
    public function __construct(string $email, int $code)
    {
        $this->email = $email;
        $this->$code = $code;
    }

    protected function generateHtml(): void
    {
        $this->html = '
            <div>
                <h1>¡Bienvenido a ' . config('app.name') . '!</h1>
                <p>Hola</p>
                <p>Recibes este correo electrónico porque hemos recibido una solicitud de una creación de una cuenta en Reciward.</p>
                <p>Debes digitar el siguiente codigo de 6 digitos para verificar tu cuenta. <br></p>
                <p>Codigo :' .$this->code. '</b> <br></p>
                <p>Si no realizaste esta solicitud, puedes ignorar este correo.</p>
            </div>
        ';
    }

    protected function generateSubject(string $subject): void
    {
        $this->subject = $subject;
    }

    public function build() : Response
    {
        $this->generateMailjetClient();
        $this->generateHtml();
        $this->generateSubject('Activación de cuenta en ' . config('app.name'));
        return $this->sendEmail();
    }
}
