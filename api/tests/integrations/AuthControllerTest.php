<?php

namespace tests\integrations;

use Laravel\Lumen\Testing\DatabaseTransactions;

class AuthControllerTest extends \TestCase
{

    use DatabaseTransactions;

    public function testInvalidEmailLogin()
    {
        // should raise if user with the email wasn't found
        $this->json('POST', 'api/v1/users/login', [
            'email' => 'invalid@notsovalid.com',
            'password' => 'goodpassword!!'
        ])->assertResponseStatus(400);
    }

    public function testInvalidPasswordLogin()
    {
        $user = factory(\App\User::class)->create();

        $this->json('POST', 'api/v1/users/login', [
            'email' => $user->email,
            'password' => 'thisissecorrectpassword'
        ])->assertResponseStatus(400);
    }

    public function testValidUserLogin()
    {
        // should work
        $user = factory(\App\User::class)->create([
            'password' => app('hash')->make('VeryGudPassword')
        ]);
        $this->json('POST', 'api/v1/users/login', [
            'email' =>  $user->email,
            'password' => 'VeryGudPassword'
        ]);
        $this->assertResponseOk();
    }
}
