<?php

namespace Dime\InvoiceBundle\Controller;

use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\View\View;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Dime\TimetrackerBundle\Controller\DimeController;

class InvoiceItemController extends DimeController
{
	private $handlerSerivce = 'dime.invoiceitem.handler';
	
	/**
	 * List all Entities.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\QueryParam(name="invoice", requirements="\d+", nullable=true, description="Filter By Invoice")
	 * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
	 * @Annotations\QueryParam(array=true, name="withtags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
	 * @Annotations\QueryParam(array=true, name="withouttags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
	 *
	 * @Annotations\View(
	 * templateVar="invoiceitems"
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @Annotations\Get("/invoiceitems", name="_invoiceitems")
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *            param fetcher service
	 *
	 * @return array
	 */
	public function getInvoiceItemsAction(ParamFetcherInterface $paramFetcher)
	{
		$result = $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
		return $result;
	}

	/**
	 * Get single Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Gets a Timeslice for a given id",
	 * output = "Dime\TimetrackerBundle\Entity\Timeslice",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when the page is not found"
	 * }
	 * )
	 *
	 * @Annotations\View(templateVar="invoicediscount")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @Annotations\Get("/invoiceitems/{id}", name="_invoiceitem")
	 *
	 * @param int $id
	 *            the page id
	 *
	 * @return array
	 *
	 * @throws NotFoundHttpException when page not exist
	 */
	public function getInvoiceItemAction($id)
	{
		return $this->getOr404($id, $this->handlerSerivce);
	}

	/**
	 * Delete existing Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when Timeslice does not exist."
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 * @Annotations\View()
	 *
	 * @Annotations\Delete("/invoiceitems/{id}", name="_invoiceitem")
	 *
	 * @param int $id
	 *            the page id
	 *
	 * @return FormTypeInterface|View
	 *
	 * @throws NotFoundHttpException when page not exist
	 */
	public function deleteInvoiceItemAction($id)
	{
		$this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}
}
