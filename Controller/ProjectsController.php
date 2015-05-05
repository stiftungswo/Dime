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

class ProjectsController extends DimeController
{
    private $handlerSerivce = 'dime.project.handler';
    
    private $formType = 'dime_timetrackerbundle_projectformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * description="Get a Collection of Projects",
     * output = "Dime\TimetrackerBundle\Entity\Project",
     * section="projects",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="customer", requirements="\d+", nullable=true, description="Filter By Project")
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(array=true, name="withtags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withouttags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher project
     *            
     * @return array
     */
    public function getProjectsAction(ParamFetcherInterface $paramFetcher)
    {
	    return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Project for a given id",
     * output = "Dime\TimetrackerBundle\Entity\Project",
     * section="projects",
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
     * @param int $id
     *            the page id
     *            
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getProjectAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

	/**
	 * Presents the form to use to create a new Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\ProjectFormType",
     * output = "Dime\TimetrackerBundle\Entity\Project",
     * description="A Frontend Function for Post for Languages which suck, Which acts on Parameters Defined in Settings",
     * section="projects",
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\View(
	 * serializerEnableMaxDepthChecks=true
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="html"})
	 * @Annotations\QueryParam(name="tags", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="user", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="name", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="customer", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="alias", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="startedAt", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="stoppedAt", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="deadline", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="description", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="budgetPrice", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="fixedPrice", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="budgetTime", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="rateGroup", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="chargeable", nullable=true, description="Sets the Value Param in the Form.")
	 *
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 * @return FormTypeInterface
	 */
    public function newProjectAction(ParamFetcherInterface $paramFetcher)
    {
        $parameters = $paramFetcher->all();
        $settingsParameters['classname'] = 'project';
        return $this->get($this->handlerSerivce)->newEntity($parameters, $settingsParameters);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new Project from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\ProjectFormType",
     * output = "Dime\TimetrackerBundle\Entity\Project",
     * section="projects",
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
    public function postProjectAction(Request $request)
    {
        try {
            $newProject = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newProject, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\ProjectFormType",
     * output = "Dime\TimetrackerBundle\Entity\Project",
     * section="projects",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Project does not exist"
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
    public function putProjectAction(Request $request, $id)
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
     * section="projects",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Project does not exist."
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
    public function deleteProjectAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
	
	/**
	 * Duplicate Entity
	 *
	 * @ApiDoc(
	 *  resource= true,
	 *  section="projects",
	 *  output = "Dime\TimetrackerBundle\Entity\Project",
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
	public function duplicateProjectAction($id)
	{
		return $this->get($this->handlerSerivce)->duplicate($this->getOr404($id, $this->handlerSerivce));
	}
}
