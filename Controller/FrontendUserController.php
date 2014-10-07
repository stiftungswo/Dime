<?php
/**
 * Author: Till Wegmüller
 * Date: 10/3/14
 * Dime
 */

namespace Dime\FrontendBundle\Controller;


use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

/**
 * Class FrontendUserController
 * @package Dime\FrontendBundle\Controller
 * @Route("/frontend/users")
 */
class FrontendUserController extends Controller {

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/view", name="frontend_users_view")
	 */
	public function viewAllAction()
	{
		return $this->render('DimeFrontendBundle:Users:view.html.twig');
	}
} 