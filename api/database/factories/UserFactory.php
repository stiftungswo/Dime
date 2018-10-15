<?php

use Faker\Generator;
use Illuminate\Database\Eloquent\Factory;

/** @var Factory $factory */
$factory->define(App\User::class, function (Faker\Generator $faker) {
    return [
        'email' => $faker->email,
        'password' => app('hash')->make($faker->password),
        'is_admin' => false
    ];
});

$factory->defineAs(App\User::class, 'admin', function () use ($factory) {
    $user = $factory->raw(App\User::class);
    $user['email'] ='office@stiftungswo.ch';
    $user['password'] = app('hash')->make('Welcome01');
    $user['is_admin'] = true;
    return $user;
});
