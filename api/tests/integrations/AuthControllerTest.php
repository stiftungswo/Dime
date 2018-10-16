<?php

namespace tests\integrations;

use App\Modules\Employee\Models\Employee;
use Laravel\Lumen\Testing\DatabaseTransactions;

class AuthControllerTest extends \TestCase
{

    use DatabaseTransactions;

    public function testInvalidEmailLogin()
    {
        // should raise if user with the email wasn't found
        $this->json('POST', 'api/v1/employees/login', [
            'email' => 'invalid@notsovalid.com',
            'password' => 'goodpassword!!'
        ])->assertResponseStatus(400);
    }

    public function testInvalidPasswordLogin()
    {
        $user = factory(Employee::class)->create();

        $this->json('POST', 'api/v1/employees/login', [
            'email' => $user->email,
            'password' => 'thisissecorrectpassword'
        ])->assertResponseStatus(400);
    }

    public function testValidUserLogin()
    {
        // should work
        $user = factory(Employee::class)->create([
            'password' => 'VeryGudPassword'
        ]);
        $this->json('POST', 'api/v1/employees/login', [
            'email' =>  $user->email,
            'password' => 'VeryGudPassword'
        ]);
        $this->assertResponseOk();
    }
}
