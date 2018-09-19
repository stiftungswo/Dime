<?php

namespace Swo\CustomerBundle\Controller;

use FOS\RestBundle\Request\ParamFetcherInterface;
use Dime\TimetrackerBundle\Controller\DimeController;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use FOS\RestBundle\View\View;
use FOS\RestBundle\Util\Codes;
use Dime\TimetrackerBundle\Exception\InvalidFormException;

class PhoneController extends DimeController
{
    private $handlerService = 'swo.phone.handler';

    /**
     * List all entities.
     *
     *
     * @ApiDoc(
     * resource = true,
     * description="Gets a Collection of Phones",
     * output = "Swo\CustomerBundle\Entity\Phone",
     * section="phones",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="company", requirements="\d+", nullable=true, description="Filter By Company")
     * @Annotations\QueryParam(name="person", requirements="\d+", nullable=true, description="Filter By Person")
     * @Annotations\QueryParam(name="type", requirements="\d+", nullable=true, description="Filter By Phone Type")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher customer
     *
     * @return array
     */
    public function getPhonesAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerService)->all($paramFetcher->all());
    }

    /**
     * Get a single entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets the corresponding phone for a given id",
     * output = "Swo\CustomerBundle\Entity\Phone",
     * section="phones",
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
     * @Annotations\Get("/phones/{id}", name="_phone")
     *
     * @param int $id
     *            the page id
     *
     * @return DimeEntityInterface
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getPhoneAction($id)
    {
        return $this->getOr404($id, $this->handlerService);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new phone from the submitted data.",
     * input = "Swo\CustomerBundle\Entity\PhoneFormType",
     * section="phones",
     * output = "Swo\CustomerBundle\Entity\Phone",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Post("/phones", name="_phone")
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
    public function postPhoneAction(Request $request)
    {
        try {
            return $this->view($this->container->get($this->handlerService)->post($request->request->all()), Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update an existing entity
     *
     * @ApiDoc(
     * resource = true,
     * input = "Swo\CustomerBundle\Form\Type\CompanyFormType",
     * output = "Swo\CustomerBundle\Entity\Company",
     * section="companies",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the phone does not exist"
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
    public function putPhoneAction(Request $request, $id)
    {
        try {
            $entity = $this->getOr404($id, $this->handlerService);
            $entity = $this->container->get($this->handlerService)->put($entity, $request->request->all());
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
     * section="phones",
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
     * @Annotations\Delete("/phones/{id}", name="_phone")
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
        $this->container->get($this->handlerService)->delete($this->getOr404($id, $this->handlerService));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
