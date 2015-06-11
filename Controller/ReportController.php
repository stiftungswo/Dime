<?php
/**
 * Author: Till Wegmüller
 * Date: 6/11/15
 * Dime
 */

namespace Dime\ReportBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class ReportController extends DimeController{
	/**
	 * List all Entities.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * section="report",
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
	 * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
	 *
	 * @Annotations\View(
	 * serializerEnableMaxDepthChecks=true
	 * )
	 *
	 * @Annotations\Route(
	 *              requirements={"_format"="json|xml"}
	 * )
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *            param fetcher offer
	 *
	 * @return array
	 */
	public function getReportsExpenseAction(ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get('dime.report.handler')->getExpenseReport($paramFetcher->all());
	}
}