<?php

namespace Dime\InvoiceBundle\Controller;

use Swo\CommonsBundle\Controller\DimeController;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class InvoiceCostgroupController extends DimeController
{
    private $handlerSerivce = 'dime.invoicecostgroup.handler';

    private $formType = 'dime_invoicebundle_invoicecostgroupformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\InvoiceBundle\Entity\InvoiceCostgroup",
     * section="invoicecostgroups",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="invoice", requirements="\d+", nullable=true, description="Filter By Invoice")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Get("/invoicecostgroups", name="_invoicecostgroup")
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *
     * @return array
     */
    public function getInvoiceCostgroupsAction(ParamFetcherInterface $paramFetcher)
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
     * output = "Dime\InvoiceBundle\Entity\InvoiceCostgroup",
     * section="invoicecostgroups",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Get("/invoicecostgroups/{id}", name="_invoicecostgroup")
     *
     * @param int $id
     *            the page id
     *
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getInvoiceCostgroupAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\InvoiceBundle\Form\Type\InvoiceCostgroupFormType",
     * output = "Dime\InvoiceBundle\Entity\InvoiceCostgroup",
     * section="invoicecostgroups",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Post("/invoicecostgroups", name="_invoicecostgroup")
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
    public function postInvoiceCostgroupAction(Request $request)
    {
        try {
            $newTimeslice = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newTimeslice, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\InvoiceBundle\Form\Type\InvoiceCostgroupFormType",
     * output = "Dime\InvoiceBundle\Entity\InvoiceCostgroup",
     * section="invoicecostgroups",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Timeslice does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Put("/invoicecostgroups/{id}", name="_invoicecostgroup")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @param Request $request
     * @param int     $id
     *            the page id
     *
     * @return FormTypeInterface|View
     *
     */
    public function putInvoiceCostgroupAction(Request $request, $id)
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
     * section="invoicecostgroups",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Timeslice does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Delete("/invoicecostgroups/{id}", name="_invoicecostgroup")
     *
     * @param int $id
     *            the page id
     *
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteInvoiceCostgroupAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
