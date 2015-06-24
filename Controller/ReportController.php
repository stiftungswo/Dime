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
use Nelmio\ApiDocBundle\Annotation\ApiDoc;

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
	 * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
	 * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
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
	 *
	 * @return array
	 */
	public function getReportsExpenseAction(ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get('dime.report.handler')->getExpenseReport($paramFetcher->all());
	}

	/**
	 * Print Offer
	 *
	 * @ApiDoc(
	 * resource = true,
	 * section="report",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
	 * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @Annotations\View(
	 * serializerEnableMaxDepthChecks=true
	 * )
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 * @return \Dime\InvoiceBundle\Entity\Invoice
	 */
	public function printReportsExpenseAction(ParamFetcherInterface $paramFetcher)
	{
		return $this->get('dime.print.pdf')->render('DimeReportBundle:Reports:ExpenseReport.pdf.twig',
			array(
				'report' => $this->container->get('dime.report.handler')->getExpenseReport($paramFetcher->all()),
			),
			'DimeReportBundle:Reports:stylesheet.xml.twig'
		);
	}
}