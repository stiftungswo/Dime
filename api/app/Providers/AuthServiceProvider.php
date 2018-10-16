<?php

namespace App\Providers;

use App\Modules\Employee\Models\Employee;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\JWT;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;
use Exception;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Boot the authentication services for the application.
     *
     * @return void
     */
    public function boot()
    {
        // Here you may define how you wish users to be authenticated for your Lumen
        // application. The callback which receives the incoming request instance
        // should return either a User instance or null. You're free to obtain
        // the User instance via an API token or any other method necessary.

        $this->app['auth']->viaRequest('jwt-auth', function ($request) {
            $token = $request->header('Authorization');

            if (!$token) {
                // Unauthorized response if token not there
                return null;
            }

            try {
                $credentials = JWT::decode(explode(' ', $token, 2)[1], env('JWT_SECRET'), ['HS256']);
            } catch (Exception $e) {
                return null;
            }

            return Employee::find($credentials->sub);

        });
    }
}
