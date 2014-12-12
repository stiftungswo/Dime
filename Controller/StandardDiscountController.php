<?php

namespace Dime\TimetrackerBundle\Controller;

use FOS\RestBundle\View\View;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;

class StandardDiscountController extends DimeController
{
    private $handlerSerivce = 'dime.standarddiscount.handler';

    private $formType = 'dime_timetrackerbundle_standarddiscountformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(array=true, name="withtags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withouttags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     *
     * @Annotations\View(
     * templateVar="standarddiscounts"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Get("/standarddiscounts", name="_standarddiscount")
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *            
     * @return array
     */
    public function getStandardDiscountsAction(ParamFetcherInterface $paramFetcher)
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
     * @Annotations\View(templateVar="standarddiscount")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Get("/standarddiscounts/{id}", name="_standarddiscount")
     *
     * @param Request $request
     *            the request object
     * @param int $id
     *            the page id
     *            
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getStandardDiscountAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

	/**
	 * Presents the form to use to create a new Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="html"})
	 * @Annotations\QueryParam(name="minus", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="percentage", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="value", nullable=true, description="Sets the Value Param in the Form.")
	 *
	 * @Annotations\View(
	 * templateVar = "form"
	 * )
     *
     * @Annotations\Get("/standarddiscounts/new", name="_standarddiscount")
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 * @return FormTypeInterface
	 */
    public function newStandardDiscountAction(ParamFetcherInterface $paramFetcher)
    {
	    return $this->get($this->handlerSerivce)->newForm($paramFetcher->all());
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Post("/standarddiscounts", name="_standarddiscount")
     *
     * @param Request $request
     *            the request object
     *            
     * @return FormTypeInterface|View
     */
    public function postStandardDiscountAction(Request $request)
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
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Timeslice does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Put("/standarddiscounts/{id}", name="_standarddiscount")
     *
     * @param int $id
     *            the page id
     *            
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     *        
     */
    public function putStandardDiscountAction(Request $request, $id)
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
     * Presents the form to use to edit a Entity.
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the Entity does not exist"
     * }
     * )
     *
     * @Annotations\View(
     * templateVar = "form"
     * )
     *
     * @Annotations\Get("/standarddiscounts/{id}/edit", name="_standarddiscount")
     *
     * @param unknown $id            
     * @return FormTypeInterface
     */
    public function editStandardDiscountAction($id)
    {
        return $this->createForm($this->formType, $this->getOr404($id, $this->handlerSerivce));
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
     * @Annotations\Delete("/standarddiscounts/{id}", name="_standarddiscount")
     *
     * @param int $id
     *            the page id
     *            
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteStandardDiscountAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
