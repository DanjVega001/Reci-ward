<?php

namespace App\Mail;

use App\Models\User;
use Mailjet\Client;
use Mailjet\Resources;
use Mailjet\Response;

abstract class BaseEmail
{
    protected $email;
    private $mailjet;
    protected $subject;
    protected $html;

    abstract protected function generateHtml(): void;
    abstract protected function generateSubject(string $subject): void;

    protected function generateMailjetClient() : void
    {
        $this->mailjet = new Client(
            env('MJ_APIKEY_PUBLIC'),
            env('MJ_APIKEY_PRIVATE'),
            true,
            ['version' => 'v3.1']
        );
    }
    private function generateBody(): array
    {
        return [
            'Messages' => [
                [
                    'From' => [
                        'Email' => env("MAIL_FROM_ADDRESS"),
                        'Name' => env("APP_NAME")
                    ],
                    'To' => [
                        [
                            'Email' => $this->email,
                            'Name' => $this->email,
                        ]
                    ],
                    'Subject' => $this->subject,
                    'HTMLPart' => $this->html
                ]
            ]
        ];
    }

    protected function sendEmail(): Response
    {
        return $this->mailjet->post(
            Resources::$Email,
            ['body' => $this->generateBody()]
        );
    }
}
