<?php
return [
    'defaults' => [
        'guard' => env('AUTH_GUARD', 'api'),
    ],

    /*
     * The driver name corresponds to the first argument given to viaRequest() in AuthServiceProvider
     */
    'guards' => [
        'api' => ['provider' => 'employees', 'driver' => 'jwt-auth'],
    ],

    'providers' => [
        'employees' => ['driver' => 'eloquent', 'model' => \App\Modules\Employee\Models\Employee::class],
    ],

];
