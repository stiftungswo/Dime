<?php

namespace Dime\TimetrackerBundle\Controller;

use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\View\View;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class TimeslicesController extends DimeController
{
    private $handlerSerivce = 'dime.timeslice.handler';

    private $formType = 'dime_timetrackerbundle_timesliceformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * output = "Dime\TimetrackerBundle\Entity\Timeslice",
     * section="timeslices",
     * description="Get Collection of Timeslices",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="activity", requirements="\d+", nullable=true, description="Filter By Activity")
     * @Annotations\QueryParam(name="date", nullable=true, description="Filter by date use Format YYYY-MM-DD or YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     * @Annotations\QueryParam(name="customer", requirements="\d+", nullable=true, description="Filter By Customer")
     * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
     * @Annotations\QueryParam(name="service", requirements="\d+", nullable=true, description="Filter By Service")
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="latest", nullable=true, description="Get Latest Timeslice")
     * @Annotations\QueryParam(array=true, name="withtags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withouttags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     *
     * @Annotations\View(
     * templateVar="timeslices"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *            
     * @return array
     */
    public function getTimeslicesAction(ParamFetcherInterface $paramFetcher)
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
     * section="timeslices",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(templateVar="timeslice")
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
    public function getTimesliceAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

	/**
	 * Presents the form to use to create a new Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * description="A Frontend Function for Post for Languages which suck, Which acts on Parameters Defined in Settings",
     * output = "Dime\TimetrackerBundle\Entity\Timeslice",
     * section="timeslices",
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="html"})
	 * @Annotations\QueryParam(name="value", nullable=true, description="Sets the Value Field")
	 * @Annotations\QueryParam(name="startedAt", nullable=true, description="Sets startedAt Field")
	 * @Annotations\QueryParam(name="stoppedAt", nullable=true, description="Sets the stoppedAt Field")
	 * @Annotations\QueryParam(name="tags", nullable=true, description="Sets the tags Field")
	 * @Annotations\QueryParam(name="user", nullable=true, description="Sets the user Field")
	 * @Annotations\QueryParam(name="activity", nullable=true, description="Sets the activity Field")
     * @Annotations\QueryParam(name="project", nullable=true, description="Limits the Activity Filed to this Project")
	 *
	 * @Annotations\View(
	 * templateVar = "form"
	 * )
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 * @return FormTypeInterface
	 */
    public function newTimesliceAction(ParamFetcherInterface $paramFetcher)
    {
        $parameters = $paramFetcher->all();
        $settingsParameters['classname'] = 'timeslice';
        if(isset($parameters['project'])){
            $settingsParameters['project'] = $parameters['project'];
            unset($parameters['project']);
        }
	    return $this->get($this->handlerSerivce)->newEntity($parameters, $settingsParameters);
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
     * @param Request $request
     *            the request object
     *            
     * @return FormTypeInterface|View
     */
    public function postTimesliceAction(Request $request)
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
     * section="timeslices",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Timeslice does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
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
    public function putTimesliceAction(Request $request, $id)
    {
        try {
            $entity = $this->getOr404($id, $this->handlerSerivce);
            $entity = $this->container->get($this->handlerSerivce)->put($entity, $request->request->all());
            return $this->view($entity, Codes::HTTP_OK);
        } catch(InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * section="timeslices",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Timeslice does not exist."
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
    public function deleteTimesliceAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
