<?php
namespace Dime\TimetrackerBundle\Controller;

use FOS\RestBundle\View\View;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use FOS\RestBundle\Request\ParamFetcherInterface;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;

class UsersController extends DimeController
{

    private $handlerSerivce = 'dime.user.handler';

    private $formType = 'dime_timetrackerbundle_userformtype';

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
     * @Annotations\QueryParam(name="firstname", requirements="\w+", nullable=true, description="Filer By Firstname")
     * @Annotations\QueryParam(name="lastname", requirements="\w+", nullable=true, description="Filer By Lastname")
     * @Annotations\QueryParam(name="username", requirements="\w+", nullable=true, description="Filer By Username")
     * @Annotations\QueryParam(name="email", requirements="\w+", nullable=true, description="Filer By email")
     * @Annotations\QueryParam(name="enabled", requirements="/^true|false$/i", nullable=true, description="Filter By enabled")
     *
     * @Annotations\View(
     * templateVar="users"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *            
     * @return array
     */
    public function getUsersAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a User for a given id",
     * output = "Dime\TimetrackerBundle\Entity\User",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(templateVar="user")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
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
    public function getUserAction($id)
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
	 * @Annotations\View(
	 * templateVar = "form"
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="html"})
	 * @Annotations\QueryParam(name="firstname", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="lastname", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="username", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="email", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="enabled", nullable=true, description="Sets the Value Param in the Form.")
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 * @return FormTypeInterface
	 */
    public function newUserAction(ParamFetcherInterface $paramFetcher)
    {
	    return $this->get($this->handlerSerivce)->newForm($paramFetcher->all());
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\UserFormType",
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
    public function postUserAction(Request $request)
    {
        try {
            $newUser = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newUser, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\UserFormType",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the User does not exist"
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
    public function putUserAction(Request $request, $id)
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
    public function editUserAction($id)
    {
        return $this->createForm($this->formType, $this->getOr404($id, $this->handlerSerivce));
    }

    /**
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\UserFormType",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when User does not exist."
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
    public function deleteUserAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }

    /**
     * Enable the User
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     */
    public function enableUserAction($id)
    {
        $this->container->get($this->handlerSerivce)->enable($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }

    /**
     * Lock the User
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     */
    public function lockUserAction($id)
    {
        $this->container->get($this->handlerSerivce)->lock($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
