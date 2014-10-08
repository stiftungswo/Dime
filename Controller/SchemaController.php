<?php
/**
 * Author: Till Wegmüller
 * Date: 10/8/14
 * Dime
 */

namespace Dime\FrontendBundle\Controller;


use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Class SchemaController
 * @package Dime\FrontendBundle\Controller
 * @Route("/api/v1/schema")
 */
class SchemaController extends Controller
{
	/**
	 * @param $entity
	 * @Route("/{entity}")
	 */
	public function indexAction($entity)
	{
		//ToDo: Method Stub. See https://github.com/SitePen/dstore/blob/master/docs/DataModelling.md
	}
} 