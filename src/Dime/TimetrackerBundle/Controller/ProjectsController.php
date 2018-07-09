<?php

namespace Dime\TimetrackerBundle\Controller;

use Dime\OfferBundle\Entity\Offer;
use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\ActivityRepository;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Entity\Timeslice;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Intl\Exception\NotImplementedException;

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
     * @Annotations\QueryParam(name="search", requirements="[\w-]+", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(array=true, name="withtags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withouttags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
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
    public function getProjectAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * List all Entities with open invoices.
     *
     * @ApiDoc(
     * resource = true,
     * description="Get a Collection of Projects with open invoices",
     * output = "Dime\TimetrackerBundle\Entity\Project",
     * section="projects",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @return array
     */
    public function getProjectsopeninvoicesAction()
    {
        return $this->container->get($this->handlerSerivce)->allProjectsWithOpenInvoices();
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
        // Find linked activities
        $activityRepository = $this->getDoctrine()->getRepository('Dime\TimetrackerBundle\Entity\Activity');
        $activities = $activityRepository->findByProject($id);

        foreach ($activities as $key => $activity) {
            // Find linked timeslices
            $timesliceRepository = $this->getDoctrine()->getRepository('Dime\TimetrackerBundle\Entity\Timeslice');
            $timeslices = $timesliceRepository->findByActivity($activity->getId());

            foreach ($timeslices as $key2 => $timeslice) {
                $this->container->get($this->handlerSerivce)->delete($timeslice);
            }

            $this->container->get($this->handlerSerivce)->delete($activity);
        }

        // Delete the project
        /** @var Project $project */
        $project = $this->getOr404($id, $this->handlerSerivce);
        $em = $this->getDoctrine()->getManager();

        // set project_id of all offers pointing to the project to null
        /** @var Offer $offer */
        foreach ($project->getOffers() as $offer) {
            $offer->setProject(null);
            $em->persist($offer);
        }
        $em->flush();
        $this->container->get($this->handlerSerivce)->delete($project);

        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }

    /**
     * Move timeslices to this project.
     *
     * Each timeslice will be moved to an activity corresponding to the service it previously belonged to.
     * If the project does not have the corresponding activity, it will be created.
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
     * @Annotations\RequestParam(name="timeslices", array=true, description="The IDs of the timeslices to move")
     *
     * @param int $projectId
     *            the page id
     *
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function putProjectTimeslicesAction(int $projectId, ParamFetcherInterface $params)
    {
        $timesliceIds = $params->get("timeslices");

        /** @var Project $targetProject */
        $targetProject = $this->getOr404($projectId, $this->handlerSerivce);

        $timesliceRepository = $this->getDoctrine()->getRepository(Timeslice::class);
        $timeslices = $timesliceRepository->findById($timesliceIds);

        $em = $this->getDoctrine()->getManager();

        /** @var Timeslice $timeslice */
        foreach ($timeslices as $timeslice) {
            $service = $timeslice->getActivity()->getService();

            /** @var Activity $targetActivity */
            $targetActivity = null;
            /** @var Activity $Activity */
            foreach ($targetProject->getActivities() as $activity) {
                if ($activity->getService()->getId() == $service->getId()) {
                    $targetActivity = $activity;
                    break;
                }
            }

            if ($targetActivity == null) {
                //create new activity for target project
                $targetActivity = clone $timeslice->getActivity();
                $targetActivity->setProject($targetProject);
                $em->persist($targetActivity);
                $em->flush();
                $targetProject->getActivities()->add($targetActivity);
            }

            $timeslice->setActivity($targetActivity);
            $em->persist($timeslice);
        }
        $em->flush();
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
