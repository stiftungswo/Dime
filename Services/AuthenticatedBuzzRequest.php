<?php

namespace Dime\InvoiceBundle\Services; 
use Buzz\Message\Request as BuzzRequest;
use Symfony\Component\Security\Core\SecurityContext;

class AuthenticatedBuzzRequest extends BuzzRequest
{
  function __construct(SecurityContext $sct)
  {
    parent::__construct();
    $user = $sct->getToken()->getUser();
    $this->addHeader('Authorization: Basic '.base64_encode($user->getUsername().':'.$user->getPassword()));
  }
}