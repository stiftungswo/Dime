<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->group(['namespace' => 'api', 'prefix' => 'api'], function () use ($router) {
    $router->group(['namespace' => 'v1', 'prefix' => 'v1'], function () use ($router) {
        $router->get('users', [
            'middleware' => 'jwt.auth',
            'uses' => 'UsersController@index'
        ]);
        $router->post('users/login', 'AuthController@authenticate');
    });
});
