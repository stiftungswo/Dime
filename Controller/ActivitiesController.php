<?php

namespace Dime\TimetrackerBundle\Controller;

use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\View\View;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;

class ActivitiesController extends DimeController
{
    private $handlerSerivce = 'dime.activity.handler';
    
    private $formType = 'dime_timetrackerbundle_activityformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     *
     * @Annotations\QueryParam(name="active", requirements="/^true|false$/i", nullable=true, description="Filter By Activity")
     * @Annotations\QueryParam(name="date", nullable=true, description="Date to filter the Activity by in Format YYYY-MM-DD")
     * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
     * @Annotations\QueryParam(name="service", requirements="\d+", nullable=true, description="Filter By Service")
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(array=true, name="withTags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withoutTags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     *
     * @Annotations\View(
     * templateVar="activities"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher activity
     *            
     * @return array
     */
    public function getActivitiesAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Activity for a given id",
     * output = "Dime\TimetrackerBundle\Entity\Activity",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(templateVar="activity")
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
    public function getActivityAction($id)
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
	 * @Annotations\QueryParam(name="value", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="description", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="rate", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="chargeable", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="service", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="project", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="tags", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="user", nullable=true, description="Sets the Value Param in the Form.")
	 *
	 * @Annotations\View(
	 * templateVar = "form"
	 * )
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 *
	 *
	 * @return FormTypeInterface
	 */
    public function newActivityAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->get($this->handlerSerivce)->newForm($paramFetcher->all());
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\ActivityFormType",
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
    public function postActivityAction(Request $request)
    {
        try {
            $newActivity = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newActivity, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\ActivityFormType",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Activity does not exist"
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
    public function putActivityAction(Request $request, $id)
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
     *
     * @param unknown $id            
     * @return FormTypeInterface
     */
    public function editActivityAction($id)
    {
        return $this->createForm($this->formType, $this->getOr404($id, $this->handlerSerivce));
    }

    /**
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\ActivityFormType",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Activity does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View()
     *
     * @param int $id
     *            the page id
     *            
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteActivityAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
