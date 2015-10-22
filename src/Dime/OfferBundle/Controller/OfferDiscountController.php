<?php

namespace Dime\OfferBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class OfferDiscountController extends DimeController
{
    private $handlerSerivce = 'dime.offerdiscount.handler';

    private $formType = 'dime_offerbundle_offerdiscountformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * section="offerdiscounts",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="offer", requirements="\d+", nullable=true, description="Filter By Service")
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
     * @Annotations\Get("/offerdiscounts", name="_offerdiscount")
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *            
     * @return array
     */
    public function getOfferDiscountsAction(ParamFetcherInterface $paramFetcher)
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
     * section="offerdiscounts",
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
     * @Annotations\Get("/offerdiscounts/{id}", name="_offerdiscount")
     *
     * @param int $id
     *            the page id
     *            
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getOfferDiscountAction($id)
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
     * output = "Dime\TimetrackerBundle\Entity\Timeslice",
     * section="offerdiscounts",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Post("/offerdiscounts", name="_offerdiscount")
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
    public function postOfferDiscountAction(Request $request)
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
     * output = "Dime\TimetrackerBundle\Entity\Timeslice",
     * section="offerdiscounts",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Timeslice does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Put("/offerdiscounts/{id}", name="_offerdiscount")
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
    public function putOfferDiscountAction(Request $request, $id)
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
     * section="offerdiscounts",
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
     * @Annotations\Delete("/offerdiscounts/{id}", name="_offerdiscount")
     *
     * @param int $id
     *            the page id
     *            
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteOfferDiscountAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
