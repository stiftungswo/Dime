<?php

namespace Swo\CustomerBundle\Controller;

use FOS\RestBundle\Request\ParamFetcherInterface;
use Swo\CommonsBundle\Controller\DimeController;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Swo\CommonsBundle\Model\DimeEntityInterface;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use FOS\RestBundle\View\View;
use FOS\RestBundle\Util\Codes;
use Dime\TimetrackerBundle\Exception\InvalidFormException;

class PersonController extends DimeController
{
    private $handlerService = 'swo.person.handler';

    /**
     * List all Entities.
     *
     *
     * @ApiDoc(
     * resource = true,
     * description="Gets a Collection of Persons",
     * output = "Swo\CustomerBundle\Entity\Person",
     * section="persons",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="name", requirements="\w+", nullable=true, description="Filter By Name")
     * @Annotations\QueryParam(name="alias", requirements="\w+", nullable=true, description="Filter By Alias")
     * @Annotations\QueryParam(name="department", requirements="\w+", nullable=true, description="Filter By Department")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(name="systemCustomer", nullable=true, description="Filter By systemCustomer")
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
    public function getPersonsAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerService)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * Annotation needed, because the FOS Rest Bundle calculates plural of person into people
     * @Annotations\Get("/persons/{id}")
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a person for a given id",
     * output = "Swo\CustomerBundle\Entity\Person",
     * section="persons",
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
    public function getPersonAction($id)
    {
        return $this->getOr404($id, $this->handlerService);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * Annotation needed, because the FOS Rest Bundle calculates plural of person into people
     * @Annotations\Post("/persons")
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Swo\CustomerBundle\Form\Type\PersonFormType",
     * output = "Swo\CustomerBundle\Entity\Person",
     * section="persons",
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
    public function postPersonAction(Request $request)
    {
        try {
            $newPerson = $this->container->get($this->handlerService)->post($request->request->all());
            return $this->view($newPerson, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * Annotation needed, because the FOS Rest Bundle calculates plural of person into people
     * @Annotations\Put("/persons/{id}")
     *
     * @ApiDoc(
     * resource = true,
     * input = "Swo\CustomerBundle\Form\Type\PersonFormType",
     * output = "Swo\CustomerBundle\Entity\Person",
     * section="persons",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Person does not exist"
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
    public function putPersonAction(Request $request, $id)
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
     * Annotation needed, because the FOS Rest Bundle calculates plural of person into people
     * @Annotations\Delete("/persons/{id}")
     *
     * @ApiDoc(
     * resource = true,
     * section="persons",
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
    public function deletePersonAction($id)
    {
        $this->container->get($this->handlerService)->delete($this->getOr404($id, $this->handlerService));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
