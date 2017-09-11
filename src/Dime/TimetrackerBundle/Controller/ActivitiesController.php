<?php

namespace Dime\TimetrackerBundle\Controller;

use Tbbc\MoneyBundle\Pair\Storage\DoctrineStorage;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Psr\Log\LoggerInterface;

class ActivitiesController extends DimeController
{
    private $handlerSerivce = 'dime.activity.handler';

    private $formType = 'dime_timetrackerbundle_activityformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     *  description = "Get Collection of Activities",
     *  section = "activities",
     *  output = "Dime\TimetrackerBundle\Entity\Ativity",
     *  statusCodes = {
     *      200 = "Returned when successful",
     *      405 = "Returned on Unsupported Method",
     *      500 = "Returned on Error"
     *  }
     * )
     *
     *
     * Annotations\QueryParam(name="active", requirements="/^true|false$/i", nullable=true, description="Deprecated: Shows Activities where there are Timeslices without EndTimes. Due to changes this can not happen. Is Ignored")
     * @Annotations\QueryParam(name="date", nullable=true, description="Filter by Date. Use Format YYYY-MM-DD. To Filter by range use YYYY-MM-DD,YYYY-MM-DD")
     * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
     * @Annotations\QueryParam(name="service", requirements="\d+", nullable=true, description="Filter By Service")
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(array=true, name="withTags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withoutTags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     * @Annotations\QueryParam(name="name", nullable=true, description="Filter on Name Property")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
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
      $filters = $paramFetcher->all();
  		$no_archived = $this->getRequest()->query->get('no_archived');

  		if($no_archived == 1) {

        $qb = $this->getDoctrine()->getManager()->createQueryBuilder();

        $qb->select('a')
          ->from('Dime\TimetrackerBundle\Entity\Activity', 'a')
          ->leftJoin('a.service', 's')
          ->where('s.archived = 0');

        //Add Ordering
        $qb->orderBy('s.name', 'ASC');
        $qb->orderBy('a.id', 'ASC');

         // Pagination
         return $qb->getQuery()->getResult();
  		}

  		return $this->container->get($this->handlerSerivce)->all($filters);
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Activity for a given id",
     * output = "Dime\TimetrackerBundle\Entity\Activity",
     * section = "activities",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found",
     * 405 = "Returned on Unsupported Method",
     * 500 = "Returned on Error"
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
    public function getActivityAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new activity from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\ActivityFormType",
     * output = "Dime\TimetrackerBundle\Entity\Activity",
     * section="activities",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
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
     * output = "Dime\TimetrackerBundle\Entity\Activity",
     * section="activities",
     * description="Update Activity Data of Given Id",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Activity does not exist"
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
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * section="activities",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Activity does not exist."
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
    public function deleteActivityAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
