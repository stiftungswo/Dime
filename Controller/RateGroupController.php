<?php

namespace Dime\TimetrackerBundle\Controller;

use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\View\View;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class RateGroupController extends DimeController
{
    private $handlerSerivce = 'dime.rategroup.handler';
    
    private $formType = 'dime_timetrackerbundle_rategroupformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\TimetrackerBundle\Entity\RateGroup",
     * section="rateGroups",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     *
     * @Annotations\View(
     * templateVar="rategroups"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher RateGroup
     *            
     * @return array
     * 
     * @Annotations\Get("/rategroups", name="_rategroups")
     */
    public function getRateGroupsAction(ParamFetcherInterface $paramFetcher)
    {
	    return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a RateGroup for a given id",
     * output = "Dime\TimetrackerBundle\Entity\RateGroup",
     * section="rateGroups",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(templateVar="rategroup")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * 
     * @Annotations\Get("/rategroups/{id}", name="_rategroups")

     * @param int $id
     *            the page id
     *            
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getRateGroupAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

	/**
	 * Presents the form to use to create a new Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\RateGroupFormType",
     * output = "Dime\TimetrackerBundle\Entity\RateGroup",
     * section="rateGroups",
     * description="A Frontend Function for Post for Languages which suck, Which acts on Parameters Defined in Settings",
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\View(
	 * templateVar = "form"
	 * )
	 *
	 * @Annotations\Get("/rategroups/new", name="_rategroups", requirements={"_format"="html"})
	 * @Annotations\QueryParam(name="tags", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="user", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="name", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="description", nullable=true, description="Sets the Value Param in the Form.")
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 * @return FormTypeInterface
	 */
    public function newRateGroupAction(ParamFetcherInterface $paramFetcher)
    {
        $parameters = $paramFetcher->all();
        $settingsParameters['classname'] = 'rategroup';
        return $this->get($this->handlerSerivce)->newEntity($parameters, $settingsParameters);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\RateGroupFormType",
     * output = "Dime\TimetrackerBundle\Entity\RateGroup",
     * section="rateGroups",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * 
     * @Annotations\Post("/rategroups", name="_rategroups")
     *
     * @param Request $request
     *            the request object
     *            
     * @return FormTypeInterface|View
     */
    public function postRateGroupAction(Request $request)
    {
        try {
            $newRateGroup = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newRateGroup, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\RateGroupFormType",
     * output = "Dime\TimetrackerBundle\Entity\RateGroup",
     * section="rateGroups",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the RateGroup does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * 
     * @Annotations\Put("/rategroups/{id}", name="_rategroups")
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
    public function putRateGroupAction(Request $request, $id)
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
     * section="rateGroups",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when RateGroup does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * 
     * @Annotations\Delete("/rategroups/{id}", name="_rategroups")
     * @Annotations\View()
     *
     * @param int $id
     *            the page id
     *            
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteRateGroupAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
