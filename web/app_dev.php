<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Debug\Debug;

// If you don't want to setup permissions the proper way, just uncomment the following PHP line
// read http://symfony.com/doc/current/book/installation.html#configuration-and-setup for more information
umask(0000);

set_time_limit(60);

// set this to true while debugging with xdebug
$xdebug = false;

if ($xdebug){
	$loader = require_once __DIR__.'/../app/autoload.php';
} else {
	$loader = require_once __DIR__.'/../app/bootstrap.php.cache';
}
Debug::enable();

require_once __DIR__.'/../app/AppKernel.php';

$kernel = new AppKernel('dev', true);
if (!$xdebug) {
	$kernel->loadClassCache();
}
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
