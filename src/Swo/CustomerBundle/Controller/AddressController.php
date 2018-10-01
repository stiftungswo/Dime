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

class AddressController extends DimeController
{
    private $handlerService = 'swo.address.handler';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * description="Gets a Collection of addresses",
     * output = "Swo\CustomerBundle\Entity\Address",
     * section="addresses",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="customer", requirements="\d+", nullable=true, description="Filter By Customer")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher address
     *
     * @return array
     */
    public function getAddressesAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerService)->all($paramFetcher->all());
    }

    /**
     * Get a single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets an address for a given id",
     * output = "Swo\CustomerBundle\Entity\Address",
     * section="addresses",
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
    public function getAddressAction($id)
    {
        return $this->getOr404($id, $this->handlerService);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Swo\CustomerBundle\Form\Type\AddressFormType",
     * output = "Swo\CustomerBundle\Entity\Address",
     * section="addresses",
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
    public function postAddressAction(Request $request)
    {
        try {
            $newAddress = $this->container->get($this->handlerService)->post($request->request->all());
            return $this->view($newAddress, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Swo\CustomerBundle\Form\Type\AddressFormType",
     * output = "Swo\CustomerBundle\Entity\Address",
     * section="addresses",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Address does not exist"
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
    public function putAddressAction(Request $request, $id)
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
     * section="addresses",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Person does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
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
    public function deleteAddressAction($id)
    {
        $this->container->get($this->handlerService)->delete($this->getOr404($id, $this->handlerService));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
