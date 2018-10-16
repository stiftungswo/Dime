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

use Laravel\Lumen\Routing\Router;

/** @var Router $router */
$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->group(['namespace' => 'api', 'prefix' => 'api'], function () use ($router) {
    $router->group(['namespace' => 'v1', 'prefix' => 'v1'], function () use ($router) {
        $router->post('employees/login', 'AuthController@authenticate');

        $router->group(['middleware' => 'auth'], function () use ($router){
            $router->get('employees', [ 'uses' => 'EmployeeController@index' ]);
            $router->post('employees', [ 'uses' => 'EmployeeController@post' ]);
            $router->get('employees/{id}', [ 'uses' => 'EmployeeController@get' ]);
            $router->put('employees/{id}', [ 'uses' => 'EmployeeController@put' ]);
            $router->delete('employees/{id}', [ 'uses' => 'EmployeeController@delete' ]);
        });
    });
});
