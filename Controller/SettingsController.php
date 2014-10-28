<?php

namespace Dime\TimetrackerBundle\Controller;

use FOS\RestBundle\View\View;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;

class SettingsController extends DimeController
{
    private $handlerSerivce = 'dime.setting.handler';
    
    private $formType = 'dime_timetrackerbundle_settingformtype';

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
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="name", requirements="\w+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="namespace", requirements="\w+", nullable=true, description="Filter By User")
     *
     * @Annotations\View(
     * templateVar="settings"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *            
     * @return array
     */
    public function getSettingsAction(ParamFetcherInterface $paramFetcher)
    {
	    return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Setting for a given id",
     * output = "Dime\TimetrackerBundle\Entity\Setting",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(templateVar="setting")
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
    public function getSettingAction($id)
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
     * @Annotations\View(
     * templateVar = "form"
     * )
     *
     * @return FormTypeInterface
     */
    public function newSettingAction()
    {
        return $this->createForm($this->formType);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\SettingFormType",
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
    public function postSettingAction(Request $request)
    {
        try {
            $newSetting = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newSetting, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\SettingFormType",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Setting does not exist"
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
    public function putSettingAction(Request $request, $id)
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
    public function editSettingAction($id)
    {
        return $this->createForm($this->formType, $this->getOr404($id, $this->handlerSerivce));
    }

    /**
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\SettingFormType",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Setting does not exist."
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
    public function deleteSettingAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
