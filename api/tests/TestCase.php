<?php

use App\Modules\Employee\Models\Employee;

abstract class TestCase extends Laravel\Lumen\Testing\TestCase
{
    /**
     * Creates the application.
     *
     * @return \Laravel\Lumen\Application
     */
    public function createApplication()
    {
        return require __DIR__.'/../bootstrap/app.php';
    }

    private const password = "Welcome01";
    /**
     * Visit the given URI with an authenticated JSON request.
     *
     * @param string      $method
     * @param string      $uri
     * @param Employee|string $user
     * @param array       $data
     * @param array       $headers
     *
     * @return TestCase
     */

    public function asAdmin(){
        //TODO: for this to work, we need to implement our authentication as a guard, not a middleware
        $user = factory(Employee::class)->create([
            "is_admin" => true
        ]);
        return $this->actingAs($user);
    }

    public function authJson($method, $uri, $user, array $data = [], array $headers = [])
    {
        if ($user === 'zivi') {
            $user = factory(Employee::class)->create([
                "password" => TestCase::password
            ]);
        } elseif ($user === 'admin') {
            $user = Employee::where('email', '=', 'office@stiftungswo.ch')->first();
            if (is_null($user)) {
                $user = factory(Employee::class, 'admin')->create([
                    "password" => TestCase::password
                ]);
            }
        }

//        var_dump($user);

        // ask the login method for a token
        $this->json('POST', 'api/v1/employees/login', [
            'email' => $user->email,
            'password' => TestCase::password
        ]);

        $content = json_decode($this->response->content());
        $token=$content->token;

        $this->assertNotEmpty($token, "Could not log in");

        return $this->json($method, $uri, $data, array_merge($headers, [
            'Authorization' => 'Bearer ' . $token,
        ]));
    }
}
