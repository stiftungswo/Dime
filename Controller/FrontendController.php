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
 * Class FrontendController
 * @package Dime\FrontendBundle\Controller
 * @Route("/frontend/ajax")
 */
class FrontendController extends Controller {

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/viewallusers", name="frontend_users_view")
	 */
	public function viewAllAction()
	{
		return $this->render('DimeFrontendBundle:Users:view.html.twig');
	}

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/timetrack/personal/month", name="frontend_timetrack_personal_month")
	 */
	public function timetrackpersonalmonth()
	{
		return $this->render('DimeFrontendBundle:Time:personal.html.twig', array('viewtype' => 'month'));
	}

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/timetrack/personal/week", name="frontend_timetrack_personal_week")
	 */
	public function timetrackpersonalweek()
	{
		return $this->render('DimeFrontendBundle:Time:personal.html.twig', array('viewtype' => 'week'));
	}

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/timetrack/personal/day", name="frontend_timetrack_personal_day")
	 */
	public function timetrackpersonalday()
	{
		return $this->render('DimeFrontendBundle:Time:personal.html.twig', array('viewtype' => 'day'));
	}
} 