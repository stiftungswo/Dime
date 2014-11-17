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
	 * @Route("/view/users", name="frontend_users_view")
	 */
	public function viewUsersAction()
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

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     * @Route("/view/offers", name="frontend_offers_view")
     */
    public function viewOffersAction()
    {
        return $this->render('DimeFrontendBundle:Offers:view.html.twig');
    }

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/view/services", name="frontend_services_view")
	 */
	public function viewServicesAction()
	{
		return $this->render('DimeFrontendBundle:Services:view.html.twig');
	}

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/view/customers", name="frontend_customers_view")
	 */
	public function viewCustomersAction()
	{
		return $this->render('DimeFrontendBundle:Customers:view.html.twig');
	}

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/view/tags", name="frontend_tags_view")
	 */
	public function viewTagsAction()
	{
		return $this->render('DimeFrontendBundle:Tags:view.html.twig');
	}

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/view/rategroups", name="frontend_rategroups_view")
	 */
	public function viewRategroupsAction()
	{
		return $this->render('DimeFrontendBundle:RateGroups:view.html.twig');
	}

	/**
	 * @return \Symfony\Component\HttpFoundation\Response
	 * @Route("/view/projects", name="frontend_projects_view")
	 */
	public function viewProjectsAction()
	{
		return $this->render('DimeFrontendBundle:Projects:view.html.twig');
	}

} 