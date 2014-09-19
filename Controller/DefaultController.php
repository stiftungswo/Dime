<?php

namespace Dime\FrontendBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('DimeFrontendBundle:Default:index.html.twig', array('name' => $name));
    }
}
