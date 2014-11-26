<?php

namespace Dime\InvoiceBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\View\View;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Symfony\Component\HttpFoundation\Request;

class InvoiceController extends DimeController
{
	private $handlerSerivce = 'dime.invoice.handler';

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
	 *
	 * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
	 * @Annotations\QueryParam(name="offer", requirements="\d+", nullable=true, description="Filter By Offer")
	 *
	 * @Annotations\View(
	 * templateVar="entity"
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *            param fetcher invoice
	 *
	 * @return array
	 */
	public function getInvoicesAction(ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
	}

	/**
	 * Get single Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Gets a Invoice for a given id",
	 * output = "Dime\TimetrackerBundle\Entity\Invoice",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when the page is not found"
	 * }
	 * )
	 *
	 * @Annotations\View(templateVar="invoice")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param int $id
	 *            the page id
	 *
	 * @return array
	 *
	 * @throws NotFoundHttpException when page not exist
	 */
	public function getInvoiceAction($id)
	{
		return $this->getOr404($id, $this->handlerSerivce);
	}

	/**
	 * Update existing Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * input = "Dime\TimetrackerBundle\Form\Type\ProjectFormType",
	 * statusCodes = {
	 * 200 = "Returned when the Entity was updated",
	 * 400 = "Returned when the form has errors",
	 * 404 = "Returned when the Project does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param Request $request
	 *            the request object
	 * @param int $id
	 *            the page id
	 *
	 * @return FormTypeInterface|View
	 *
	 * @throws NotFoundHttpException when page not exist
	 *
	 */
	public function putInvoiceAction(Request $request, $id)
	{
		try {
			$entity = $this->getOr404($id, $this->handlerSerivce);
			$entity = $this->container->get($this->handlerSerivce)->put($entity, $request->request->all());
			return $this->view($entity, Codes::HTTP_OK);
		} catch (InvalidFormException $exception) {
			return $exception->getForm();
		}
	}

	/**
	 * Delete existing Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * input = "Dime\TimetrackerBundle\Form\Type\InvoiceFormType",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when Invoice does not exist."
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @Annotations\View()
	 *
	 * @param int $id
	 *            the page id
	 *
	 * @return FormTypeInterface|View
	 *
	 * @throws NotFoundHttpException when page not exist
	 */
	public function deleteInvoiceAction($id)
	{
		$this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}

	/**
	 * Create Invice from Project
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\View(templateVar="invoice")
	 *
	 * @Annotations\Get("/invoices/project/{id}", name="_invoices")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 * @param $id
	 *
	 * @return \Dime\InvoiceBundle\Entity\Invoice
	 */
	public function createInvoiceFromProjectAction($id)
	{
		return $this->container->get($this->handlerSerivce)->createFromProject($this->getOr404($id, 'dime.project.handler'));
	}

	/**
	 * Print Invoice
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Get("/invoices/{id}/print", name="_invoices_print")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 * @param $id
	 *
	 * @return \Dime\InvoiceBundle\Entity\Invoice
	 */
	public function printInvoiceAction($id)
	{
		return $this->get('dime.print.pdf')->render('DimeInvoiceBundle:Invoice:print.pdf.twig', array('invoice' => $this->getOr404($id, $this->handlerSerivce)));
	}

	/**
	 * Update Invoice
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Get("/invoices/{id}/update", name="_invoices_update")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 * @param $id
	 *
	 * @return \Dime\InvoiceBundle\Entity\Invoice
	 */
	public function updateInvoiceAction($id)
	{
		return $this->get($this->handlerSerivce)->updateInvoiceItems($this->getOr404($id, $this->handlerSerivce));
	}
}