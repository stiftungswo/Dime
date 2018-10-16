<?php

namespace tests\integrations;

use App\Modules\Employee\Models\Employee;
use Laravel\Lumen\Testing\DatabaseTransactions;

class EmployeeControllerTest extends \TestCase
{

    use DatabaseTransactions;

    public function testPasswordIsHashed()
    {
        // should raise if user with the email wasn't found
//        $this->asAdmin()->json('POST', 'api/v1/employees/', [
        $this->authJson('POST', 'api/v1/employees/', 'admin', [
            'email' => 'test@stiftungswo.ch',
            'password' => 'gurken',
            'first_name' => 'Max',
            'last_name' => 'Muster',
        ]);

        $this->assertResponseOk();

        $e = Employee::orderBy('id', 'desc')->first();

        $this->assertEquals('test@stiftungswo.ch', $e->email);
        $this->assertStringStartsWith('$', $e->password);
    }
}
