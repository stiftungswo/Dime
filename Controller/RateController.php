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

class RateController extends DimeController
{
    private $handlerSerivce = 'dime.rate.handler';
    
    private $formType = 'dime_timetrackerbundle_rateformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\TimetrackerBundle\Entity\Rate",
     * section="rates",
     * description="Get a Collection of Rates",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(name="service", requirements="\d+", nullable=true, description="Filter By Service")
     *
     * @Annotations\View(
     * templateVar="rates"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher Rate
     *            
     * @return array
     * 
     */
    public function getRatesAction(ParamFetcherInterface $paramFetcher)
    {
	    return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Rate for a given id",
     * output = "Dime\TimetrackerBundle\Entity\Rate",
     * section="rates",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(templateVar="rate")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     *
     * @param int $id
     *            the page id
     *            
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getRateAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Presents the form to use to create a new Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\RateFormType",
     * output = "Dime\TimetrackerBundle\Entity\Rate",
     * description="A Frontend Function for Post for Languages which suck, Which acts on Parameters Defined in Settings",
     * section="rates",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\View(
     * templateVar = "form"
     * )
     *
     * @Annotations\Route(requirements={"_format"="html"})
     * @Annotations\QueryParam(name="tags", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="user", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="rateGroup", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="rateUnit", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="rateUnitType", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="service", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="value", nullable=true, description="Sets the Value Param in the Form.")
     *
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     *
     * @return mixed
     */
    public function newRateAction(ParamFetcherInterface $paramFetcher)
    {
        $parameters = $paramFetcher->all();
        $settingsParameters['classname'] = 'rate';
        return $this->get($this->handlerSerivce)->newEntity($parameters, $settingsParameters);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\RateFormType",
     * output = "Dime\TimetrackerBundle\Entity\Rate",
     * section="rates",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * 
     *
     * @param Request $request
     *            the request object
     *            
     * @return FormTypeInterface|View
     */
    public function postRateAction(Request $request)
    {
        try {
            $newRate = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newRate, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\RateFormType",
     * output = "Dime\TimetrackerBundle\Entity\Rate",
     * section="rates",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Rate does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * 
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
    public function putRateAction(Request $request, $id)
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
     * section="rates",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Rate does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * @Annotations\View()
     *
     * @param int $id
     *            the page id
     *            
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteRateAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }

	/**
	 * Duplicate Entity
	 *
	 * @ApiDoc(
	 *  resource= true,
	 *  section="rates",
	 *  output = "Dime\TimetrackerBundle\Entity\Rate",
	 *  statusCodes={
	 *      200 = "Returned when successful",
	 *      404 = "Returned when entity does not exist"
	 *  }
	 * )
	 *
	 * @Annotations\Get("/rates/{id}/duplicate", name="_rates_dup")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param $id
	 *
	 * @return \Dime\TimetrackerBundle\Model\DimeEntityInterface
	 */
	public function duplicateRateAction($id)
	{
		return $this->get($this->handlerSerivce)->duplicate($this->getOr404($id, $this->handlerSerivce));
	}
}
