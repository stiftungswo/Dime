<?php
namespace Dime\TimetrackerBundle\Controller;

use Dime\TimetrackerBundle\Entity\User;
use Dime\TimetrackerBundle\Entity\UserRepository;
use Dime\TimetrackerBundle\Form\UserType;
use FOS\RestBundle\View\View;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use FOS\RestBundle\Request\ParamFetcherInterface;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;

class UsersController extends DimeController
{

    /**
     * List all users.
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="offset", requirements="\d+", nullable=true, description="Offset from which to start listing users.")
     * @Annotations\QueryParam(name="limit", requirements="\d+", default="5", description="How many users to return.")
     *
     * @Annotations\View(
     * templateVar="users"
     * )
     *
     * @param Request $request
     *            the request object
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *            
     * @return array
     */
    public function getUsersAction(Request $request, ParamFetcherInterface $paramFetcher)
    {
        $offset = $paramFetcher->get('offset');
        $offset = null == $offset ? 0 : $offset;
        $limit = $paramFetcher->get('limit');
        return $this->container->get('dime.user.handler')->all($limit, $offset);
    }

    /**
     * Get single User,
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
        return $this->getOr404($id);
    }

    /**
     * Create a Page from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\UserType",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\View(
     * template = "AcmeBlogBundle:Page:newPage.html.twig",
     * statusCode = Codes::HTTP_BAD_REQUEST,
     * templateVar = "form"
     * )
     *
     * @param Request $request
     *            the request object
     *            
     * @return FormTypeInterface|View
     */
    public function postUserAction(Request $request)
    {
//         return $this->container->get('dime.user.handler')->post($request->request->all());
        try {
            $newUser = $this->container->get('dime.user.handler')->post($request->request->all());
            $routeOptions = array(
                'id' => $newUser->getId(),
                '_format' => $request->get('_format')
            );
            return $this->routeRedirectView('api_1_get_user', $routeOptions, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing user from the submitted data or create a new user at a specific location.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\UserType",
     * statusCodes = {
     * 201 = "Returned when the User is created",
     * 204 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
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
    public function putUserAction(Request $request, $id)
    {
        try {
            if (! ($user = $this->container->get('dime.user.handler')->get($id))) {
                $statusCode = Codes::HTTP_CREATED;
                $user = $this->container->get('dime.user.handler')->post($request->request->all());
            } else {
                $statusCode = Codes::HTTP_NO_CONTENT;
                $user = $this->container->get('dime.user.handler')->put($user, $request->request->all());
            }
            $routeOptions = array(
                'id' => $user->getId(),
                '_format' => $request->get('_format')
            );
            return $this->routeRedirectView('api_1_get_user', $routeOptions, $statusCode);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing page from the submitted data or create a new page at a specific location.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\UserType",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
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
     */
    public function deleteUserAction(Request $request, $id)
    {
        try {
            $user = $this->container->get('dime.user.handler')->patch($this->getOr404($id), $request->request->all());
            $routeOptions = array(
                'id' => $user->getId(),
                '_format' => $request->get('_format')
            );
            return $this->routeRedirectView('api_1_get_user', $routeOptions, Codes::HTTP_NO_CONTENT);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }
    
    /**
     * Update existing user from the submitted data or create a new page at a specific location.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\UserType",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\View(
     * template = "AcmeBlogBundle:Page:editPage.html.twig",
     * templateVar = "form"
     * )
     *
     * @param Request $request the request object
     * @param int $id the page id
     *
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function patchUserAction(Request $request, $id)
    {
        try {
            $user = $this->container->get('dime.user.handler')->patch(
                $this->getOr404($id),
                $request->request->all()
            );
            $routeOptions = array(
                'id' => $user->getId(),
                '_format' => $request->get('_format')
            );
            return $this->routeRedirectView('api_1_get_user', $routeOptions, Codes::HTTP_NO_CONTENT);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }
    
    /**
     * Fetch a User or throw an 404 Exception.
     *
     * @param mixed $id
     *
     * @return UserInterface
     *
     * @throws NotFoundHttpException
     */
    protected function getOr404($id)
    {
        if (!($user = $this->container->get('user.user.handler')->get($id))) {
            throw new NotFoundHttpException(sprintf('The resource \'%s\' was not found.',$id));
        }
        return $user;
    }
}
