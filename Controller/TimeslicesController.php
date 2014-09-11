<?php

namespace Dime\TimetrackerBundle\Controller;

use FOS\RestBundle\View\View;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;

class TimeslicesController extends DimeController
{
    

    /**
     * List all Timeslices.
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     * 
     * @Annotations\QueryParam(name="offset", requirements="\d+", nullable=true, description="Offset from which to start listing timeslices.")
     * @Annotations\QueryParam(name="limit", requirements="\d+", default="5", description="How many timeslices to return.")
     * @Annotations\QueryParam(array=true, name="filter", description="List of filters")
     *
     * @Annotations\View(
     * templateVar="timeslices"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param Request $request
     *            the request object
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher service
     *            
     * @return array
     */
    public function getTimeslicesAction(Request $request, ParamFetcherInterface $paramFetcher)
    {
        $offset = $paramFetcher->get('offset');
        $offset = null == $offset ? 0 : $offset;
        $limit = $paramFetcher->get('limit');
        $filter = $paramFetcher->get('filter');
        return $this->container->get('dime.timeslice.handler')->all($limit, $offset, $filter);
    }

    /**
     * Get single Timeslice,
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Timeslice for a given id",
     * output = "Dime\TimetrackerBundle\Entity\Timeslice",
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
     * @param Request $request
     *            the request object
     * @param int $id
     *            the page id
     *            
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getTimesliceAction($id)
    {
        return $this->getOr404($id, 'dime.timeslice.handler');
    }

    /**
     * Presents the form to use to create a new timeslice.
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
    public function newTimesliceAction()
    {
        return $this->createForm('dime_timetrackerbundle_timesliceformtype', array(
            'timeslice' => $this->container->get('fos_timeslice.timeslice_manager')->createTimeslice())
        );
    }

    /**
     * Create a new Timeslice from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * statusCodes = {
     * 200 = "Returned when successful",
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
            $newentity = $this->container->get('dime.timeslice.handler')->post($request->request->all());
            $routeOptions = array(
                'id' => $newentity->getId(),
                '_format' => $request->get('_format')
            );
            return $this->routeRedirectView('api_1_get_timeslice', $routeOptions, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing timeslice from the submitted data or create a new timeslice at a specific location.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * statusCodes = {
     * 201 = "Returned when the Timeslice is created",
     * 204 = "Returned when successful",
     * 400 = "Returned when the form has errors"
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
            if (! ($timeslice = $this->container->get('dime.timeslice.handler')->get($id))) {
                $statusCode = Codes::HTTP_CREATED;
                $timeslice = $this->container->get('dime.timeslice.handler')->post($request->request->all());
            } else {
                $statusCode = Codes::HTTP_NO_CONTENT;
                $timeslice = $this->container->get('dime.timeslice.handler')->put($timeslice, $request->request->all());
            }
            $routeOptions = array(
                'id' => $timeslice->getId(),
                '_format' => $request->get('_format')
            );
            return $this->routeRedirectView('api_1_get_timeslice', $routeOptions, $statusCode);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Presents the form to use to edit a timeslice.
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
     * 
     * @param unknown $id
     * @return FormTypeInterface
     */
    public function editTimesliceAction($id)
    {
        return $this->createForm('dime_timetrackerbundle_timesliceformtype', $this->getOr404($id, 'dime.timeslice.handler'));
    }

    /**
     * Delete existing timeslice
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * statusCodes = {
     * 204 = "Returned when successful",
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
     */
    public function deleteTimesliceAction(Request $request, $id)
    {
        $this->container->get('dime.timeslice.handler')->delete($this->getOr404($id, 'dime.timeslice.handler'));
        return $this->routeRedirectView('api_1_get_timeslices', array(), Codes::HTTP_NO_CONTENT);
    }

    /**
     * Update existing timeslice from subset of data
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\TimesliceFormType",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 400 = "Returned when the form has errors"
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
     */
    public function patchTimesliceAction(Request $request, $id)
    {
        try {
            $timeslice = $this->container->get('dime.timeslice.handler')->patch($this->getOr404($id, 'dime.timeslice.handler'), $request->request->all());
            $routeOptions = array(
                'id' => $timeslice->getId(),
                '_format' => $request->get('_format')
            );
            return $this->routeRedirectView('api_1_get_timeslice', $routeOptions, Codes::HTTP_NO_CONTENT);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }
}
