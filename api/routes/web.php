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

        $router->group(['middleware' => 'auth'], function () use ($router) {

            $router->group(['prefix'=>'employees'], function () use ($router) {
                $router->get('/', [ 'uses' => 'EmployeeController@index' ]);
                $router->post('/', [ 'uses' => 'EmployeeController@post' ]);
                $router->get('/{id}', [ 'uses' => 'EmployeeController@get' ]);
                $router->put('/{id}', [ 'uses' => 'EmployeeController@put' ]);
                $router->delete('/{id}', [ 'uses' => 'EmployeeController@delete' ]);
            });

            $router->group(['prefix'=>'services'], function () use ($router) {
                $router->get('/', [ 'uses' => 'ServiceController@index' ]);
                $router->post('/', [ 'uses' => 'ServiceController@post' ]);
                $router->get('/{id}', [ 'uses' => 'ServiceController@get' ]);
                $router->put('/{id}', [ 'uses' => 'ServiceController@put' ]);
                $router->delete('/{id}', [ 'uses' => 'ServiceController@delete' ]);
            });
        });
    });
});
