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

class OfferStatusUCController extends DimeController
{
    private $handlerSerivce = 'dime.offerstatusuc.handler';
    
    private $formType = 'dime_offerbundle_offerstatusucformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\OfferBundle\Entity\OfferStatusUC",
     * section="offerstatusucs",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Get("/offerstatusucs", name="_offerstatusucs")
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher offer
     *            
     * @return array
     */
    public function getOfferStatusUCsAction(ParamFetcherInterface $paramFetcher)
    {
	    return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets an offer for a given id",
     * output = "Dime\OfferBundle\Entity\OfferStatusUC",
     * section="offerstatusucs",
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
     * @Annotations\Get("/offerstatusucs/{id}", name="_offerstatusucs")
     *
     * @param int $id
     *            the page id
     *            
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getOfferStatusUCAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\OfferBundle\Form\Type\OfferStatusUCFormType",
     * output = "Dime\OfferBundle\Entity\OfferStatusUC",
     * section="offerstatusucs",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Post("/offerstatusucs", name="_offerstatusucs")
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
    public function postOfferStatusUCAction(Request $request)
    {
        try {
            $newOffer = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newOffer, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\OfferBundle\Form\Type\OfferStatusUCFormType",
     * output = "Dime\OfferBundle\Entity\OfferStatusUC",
     * section="offerstatusucs",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Offer does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Put("/offerstatusucs/{id}", name="_offerstatusucs")
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
    public function putOfferStatusUCAction(Request $request, $id)
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
     * output = "Dime\OfferBundle\Entity\OfferStatusUC",
     * section="offerstatusucs",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when offer does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\Delete("/offerstatusucs/{id}", name="_offerstatusucs")
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
    public function deleteOfferStatusUCAction($id)
    {
        //TODO urfr only set status to inactive
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
