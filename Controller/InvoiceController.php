<?php

namespace Dime\InvoiceBundle\Controller;

use FOS\RestBundle\Request\ParamFetcherInterface;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;

class InvoiceController extends Controller
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
	 * @Annotations\RequestParam(name="id", requirements="\d+", description="The ID of the Customer")
	 *
	 * @Annotations\View(
	 * templateVar="invoices"
	 * )
	 *
	 * @Annotations\Get("/invoices/customer/{id}")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 *
	 * @param $id
	 *
	 * @return array
	 */
	public function getInvoicesByCustomerAction($id)
	{
		return $this->container->get($this->handlerSerivce)->allByCustomer($id);
	}

}