<?php

namespace Dime\InvoiceBundle\Controller;

use Ps\PdfBundle\Annotation\Pdf;
use FOS\RestBundle\Controller\FOSRestController;
use FOS\RestBundle\Request\ParamFetcherInterface;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class InvoiceController extends FOSRestController
{
	private $handlerSerivce = 'dime.invoice.handler';

	/**
	 * Get all Invoices for a Customer specified by id,
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\RequestParam(name="nonchargeable", nullable=true, requirements="/^true|false$/i", default="false", description="Whether to include nonchargeable projects or not.")
	 * @Annotations\RequestParam(name="fixed", nullable=true, requirements="/^true|false$/i", default="false", description="Report Fixed Summ in Invoice")
	 * @Annotations\RequestParam(name="details", nullable=true, requirements="/^true|false$/i", default="false", description="Report Charge Details in Invoice")
	 * @Annotations\RequestParam(name="discounts", array=true, requirements="\d+", nullable=true, description="Ids of the Discounts to apply")
	 *
	 * @Annotations\View(
	 * templateVar="invoices"
	 * )
	 *
	 * @Annotations\Get("/invoices/customer/{id}")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param                       $id
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 *
	 * @return array
	 */
	public function getInvoicesByCustomerAction($id, ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get($this->handlerSerivce)->allByCustomer($id,
			$paramFetcher->get('nonchargeable', true),
			$paramFetcher->get('fixed', true),
			$paramFetcher->get('details', true),
			$paramFetcher->get('discounts', true)
		);
	}

	/**
	 * Get all Invoices for a Service specified by id,
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\RequestParam(name="nonchargeable", nullable=true, default="false", description="The ID of the Customer")
	 * @Annotations\RequestParam(name="fixed", nullable=true, default="false", description="Report Fixed Summ in Invoice")
	 * @Annotations\RequestParam(name="details", nullable=true, default="false", description="Report Charge Details in Invoice")
	 *
	 * @Annotations\View(
	 * templateVar="invoices"
	 * )
	 *
	 * @Annotations\Get("/invoices/service/{id}")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param                       $id
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 *
	 * @return array
	 */
	public function getInvoicesByServiceAction($id, ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get($this->handlerSerivce)->allByService($id,
			$paramFetcher->get('nonchargeable', true),
			$paramFetcher->get('fixed', true),
			$paramFetcher->get('details', true),
			$paramFetcher->get('discounts', true)
		);
	}

	/**
	 * Get all Invoices for a Project specified by id,
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\RequestParam(name="nonchargeable", nullable=true, default="false", description="The ID of the Customer")
	 * @Annotations\RequestParam(name="fixed", nullable=true, default="false", description="Report Fixed Summ in Invoice")
	 * @Annotations\RequestParam(name="details", nullable=true, default="false", description="Report Charge Details in Invoice")
	 *
	 * @Annotations\View(
	 * templateVar="invoices"
	 * )
	 *
	 * @Annotations\Get("/invoices/project/{id}")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param                       $id
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 *
	 * @return array
	 */
	public function getInvoicesByProjectAction($id, ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get($this->handlerSerivce)->allByProject($id,
			$paramFetcher->get('nonchargeable', true),
			$paramFetcher->get('fixed', true),
			$paramFetcher->get('details', true),
			$paramFetcher->get('discounts', true)
		);
	}

	/**
	 * @Annotations\Get("/invoices/print/{name}", name="print_invoice", requirements={"_format"="pdf"})
	 *
	 * @param         $name
	 *
	 * @return \Symfony\Component\HttpFoundation\Response
	 */
	public function printInvoiceAction($name)
	{
		return $this->get('dime.print.pdf')->render('DimeInvoiceBundle:Invoice:test.pdf.twig', array('name' => $name));
	}

}