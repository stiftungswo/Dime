<?php

namespace Dime\FrontendBundle\Controller;


use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends Controller
{

	/**
	 * @Route("/")
	 */
    public function indexAction()
    {
        return $this->render('DimeFrontendBundle:Default:index.html.twig');
    }
}
