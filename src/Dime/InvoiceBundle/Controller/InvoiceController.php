<?php

namespace Dime\InvoiceBundle\Controller;

use Dime\InvoiceBundle\Entity\Invoice;
use Dime\PrintingBundle\Service\PrintService;
use Swo\CommonsBundle\Controller\DimeController;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Swo\CommonsBundle\Model\DimeEntityInterface;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class InvoiceController extends DimeController
{
    private $handlerSerivce = 'dime.invoice.handler';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\InvoiceBundle\Entity\Invoice",
     * section="invoices",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     *
     * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
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
     * output = "Dime\InvoiceBundle\Entity\Invoice",
     * section="invoices",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List", "Default"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param int $id
     *            the page id
     *
     * @return DimeEntityInterface
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getInvoiceAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new Invoice from the submitted data.",
     * input = "Dime\InvoiceBundle\Form\Type\InvoiceFormType",
     * section="invoices",
     * output = "Dime\InvoiceBundle\Entity\Invoice",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @param Request $request
     *            the request object
     *
     * @return FormTypeInterface|View
     */
    public function postInvoiceAction(Request $request)
    {
        try {
            $entity = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($entity, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\InvoiceBundle\Form\Type\InvoiceFormType",
     * output = "Dime\InvoiceBundle\Entity\Invoice",
     * section="invoices",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Project does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
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
     * input = "Dime\InvoiceBundle\Form\Type\InvoiceFormType",
     * output = "Dime\InvoiceBundle\Entity\Invoice",
     * section="invoices",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Invoice does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
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
     * output = "Dime\InvoiceBundle\Entity\Invoice",
     * section="invoices",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
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
     * section="invoices",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\Get("/invoices/{id}/print", name="_invoices_print")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     * @param $id
     *
     * @return Response
     */
    public function printInvoiceAction($id)
    {
        // disable notices from PHPPdf which breaks this
        error_reporting(E_ALL & ~E_NOTICE);
        /** @var PrintService $printService */
        $printService = $this->get('dime.print.pdf');
        /** @var Invoice $invoice */
        $invoice = $this->getOr404($id, $this->handlerSerivce);

        $search = ['/ö/', '/ü/', '/ä/', '/é/', '/è/', '/ê/', '/[^\w]+/'];
        $replace = ['oe', 'ue', 'ae', 'e', 'e', 'e', '-'];
        $cleanInvoiceName = trim(preg_replace($search, $replace, $invoice->getName()), '-');
        $header = [
            'Content-Disposition' => sprintf('filename="%s_%s.pdf"', $cleanInvoiceName, $invoice->getId()),
        ];

        return $printService->render('DimeInvoiceBundle:Invoice:print.pdf.twig', ['invoice' => $invoice], 'DimeInvoiceBundle:Invoice:stylesheet.xml.twig', $header);
    }

    /**
     * Update Invoice
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\InvoiceBundle\Entity\Invoice",
     * section="invoices",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\Get("/invoices/{id}/update", name="_invoices_update")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     * @param $id
     *
     * @return \Dime\InvoiceBundle\Entity\Invoice
     */
    public function updateInvoiceAction($id)
    {
        return $this->get($this->handlerSerivce)->updateInvoice($this->getOr404($id, $this->handlerSerivce));
    }
}
