<?php

namespace Dime\InvoiceBundle\Controller;

use Swo\CommonsBundle\Controller\DimeController;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Swo\CommonsBundle\Model\DimeEntityInterface;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class CostgroupController extends DimeController
{
    private $handlerSerivce = 'dime.costgroup.handler';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\InvoiceBundle\Entity\Costgroup",
     * section="costgroups",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Get("/costgroups", name="_costgroups")
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *
     * @return array
     */
    public function getCostgroupsAction(ParamFetcherInterface $paramFetcher)
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
     * output = "Dime\InvoiceBundle\Entity\Costgroup",
     * section="costgroups",
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
     * @Annotations\Get("/costgroups/{id}", name="_costgroup")
     *
     * @param int $id
     *            the page id
     *
     * @return DimeEntityInterface
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getCostgroupAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new InvoiceItem from the submitted data.",
     * input = "Dime\InvoiceBundle\Form\Type\InvoiceItemFormType",
     * section="invoices",
     * output = "Dime\InvoiceBundle\Entity\InvoiceItem",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Post("/invoiceitems", name="_invoiceitem")
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
     /*
    public function postInvoiceItemAction(Request $request)
    {
        try {
            return $this->view($this->container->get($this->handlerSerivce)->post($request->request->all()), Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }*/

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\InvoiceBundle\Form\Type\InvoiceItemFormType",
     * output = "Dime\InvoiceBundle\Entity\InvoiceItem",
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
     * @Annotations\Put("/invoiceitems/{id}", name="_invoiceitem")
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
     /*
    public function putInvoiceItemAction(Request $request, $id)
    {
        try {
            $entity = $this->getOr404($id, $this->handlerSerivce);
            $entity = $this->container->get($this->handlerSerivce)->put($entity, $request->request->all());
            return $this->view($entity, Codes::HTTP_OK);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }*/

    /**
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * section="invoiceitems",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Entity does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
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
     /*
    public function deleteInvoiceItemAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }*/
}
