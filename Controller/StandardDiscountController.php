<?php

namespace Dime\TimetrackerBundle\Controller;

use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class StandardDiscountController extends DimeController
{
    private $handlerSerivce = 'dime.standarddiscount.handler';

    private $formType = 'dime_timetrackerbundle_standarddiscountformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\TimetrackerBundle\Entity\StandardDiscount",
     * section="standarddiscounts",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(array=true, name="withtags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withouttags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
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
     * output = "Dime\TimetrackerBundle\Entity\StandardDiscount",
     * section="standarddiscounts",
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
     * @Annotations\Get("/standarddiscounts/{id}", name="_standarddiscount")
     *
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
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * output = "Dime\TimetrackerBundle\Entity\StandardDiscount",
     * section="standarddiscounts",
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
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
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
     * output = "Dime\TimetrackerBundle\Entity\StandardDiscount",
     * section="standarddiscounts",
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
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @param Request $request
     * @param int     $id
     *            the page id
     *
     * @return View|FormTypeInterface
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
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * section="standarddiscounts",
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

	/**
	 * Duplicate Entity
	 *
	 * @ApiDoc(
	 *  resource= true,
	 *  section="standarddiscounts",
	 *  output = "Dime\TimetrackerBundle\Entity\StandardDiscount",
	 *  statusCodes={
	 *      200 = "Returned when successful",
	 *      404 = "Returned when entity does not exist"
	 *  }
	 * )
	 *
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @Annotations\View(
	 * serializerEnableMaxDepthChecks=true
	 * )
	 *
	 * @param $id
	 *
	 * @return \Dime\TimetrackerBundle\Model\DimeEntityInterface
	 */
	public function duplicateStandardDiscountAction($id)
	{
		return $this->get($this->handlerSerivce)->duplicate($this->getOr404($id, $this->handlerSerivce));
	}
}
