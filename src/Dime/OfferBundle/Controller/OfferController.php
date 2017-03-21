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

class OfferController extends DimeController
{
    private $handlerSerivce = 'dime.offer.handler';
    
    private $formType = 'dime_offerbundle_offerformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * section="offers",
     * output = "Dime\OfferBundle\Entity\Offer",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher offer
     *
     * @return array
     */
    public function getOffersAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets an offer for a given id",
     * section="offers",
     * output = "Dime\OfferBundle\Entity\Offer",
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
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getOfferAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new Offer from the submitted data.",
     * input = "Dime\OfferBundle\Form\Type\OfferFormType",
     * section="offers",
     * output = "Dime\OfferBundle\Entity\Offer",
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
    public function postOfferAction(Request $request)
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
     * input = "Dime\OfferBundle\Form\Type\OfferFormType",
     * section="offers",
     * output = "Dime\OfferBundle\Entity\Offer",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Offer does not exist"
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
    public function putOfferAction(Request $request, $id)
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
     * section="offers",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when offer does not exist."
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
    public function deleteOfferAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }


    /**
     * Create Project from Offer
     *
     * @ApiDoc(
     * resource = true,
     * section="offers",
     * output="Dime\TimetrackerBundle\Entity\Project",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\Get("/projects/offer/{id}", name="_offers")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     * @param $id
     *
     * @return \Dime\TimetrackerBundle\Entity\Project
     */
    public function createProjectFromOfferAction($id)
    {
        return $this->container->get($this->handlerSerivce)->createProjectFromOffer($this->getOr404($id, $this->handlerSerivce));
    }

    /**
     * Print Offer
     *
     * @ApiDoc(
     * resource = true,
     * section="offers",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\Get("/offers/{id}/print", name="_offers_print")
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
    public function printOfferAction($id)
    {
        // disable notices from PHPPdf which breaks this
        error_reporting(E_ALL & ~E_NOTICE);
        return $this->get('dime.print.pdf')->render('DimeOfferBundle:Offer:print.pdf.twig', array('offer' => $this->getOr404($id, $this->handlerSerivce)), 'DimeOfferBundle:Offer:stylesheet.xml.twig');
    }
}
