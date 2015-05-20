<?php
namespace Dime\EmployeeBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class PeriodController extends DimeController
{

	private $handlerSerivce = 'dime.period.handler';

	private $formType = 'dime_timetrackerbundle_periodformtype';

	/**
	 * List all Entities.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * output = "Dime\EmployeeBundle\Entity\Period",
	 * section="periods",
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\QueryParam(name="firstname", nullable=true, description="Filer By Firstname")
	 * @Annotations\QueryParam(name="lastname", nullable=true, description="Filer By Lastname")
	 * @Annotations\QueryParam(name="fullname", nullable=true, description="Filer By Fullname")
	 * @Annotations\QueryParam(name="username", nullable=true, description="Filer By Username")
	 * @Annotations\QueryParam(name="email", nullable=true, description="Filer By email")
	 * @Annotations\QueryParam(name="enabled", requirements="/^true|false$/i", nullable=true, description="Filter By enabled")
	 *
	 * @Annotations\View(
	 * templateVar="periods"
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *            param fetcher service
	 *
	 * @return array
	 */
	public function getPeriodsAction(ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
	}

	/**
	 * Get single Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Gets a Period for a given id",
	 * output = "Dime\EmployeeBundle\Entity\Period",
	 * section="periods",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when the page is not found"
	 * }
	 * )
	 *
	 * @Annotations\View(templateVar="period")
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
	public function getPeriodAction($id)
	{
		return $this->getOr404($id, $this->handlerSerivce);
	}

	/**
	 * Presents the form to use to create a new Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * section="periods",
	 * output = "Dime\EmployeeBundle\Entity\Period",
	 * input = "Dime\EmployeeBundle\Form\Type\PeriodFormType",
	 * description="A Frontend Function for Post for Languages which suck, Which acts on Parameters Defined in Settings",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 405 = "Returned on Unsupported Method",
	 * 500 = "Returned on Error"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="html"})
	 * @Annotations\QueryParam(name="start", nullable=true, description="Sets the Period Start")
	 * @Annotations\QueryParam(name="end", nullable=true, description="Sets the Period End")
	 *
	 *
	 * @Annotations\View(
	 * templateVar = "form"
	 * )
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 *
	 *
	 */
	public function newActivityAction(ParamFetcherInterface $paramFetcher)
	{
		$parameters = $paramFetcher->all();
		$settingsParameters['classname'] = 'period';
		return $this->get($this->handlerSerivce)->newEntity($parameters, $settingsParameters);
	}

	/**
	 * Create a new Entity from the submitted data.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Creates a new page from the submitted data.",
	 * input = "Dime\EmployeeBundle\Form\Type\PeriodFormType",
	 * output = "Dime\EmployeeBundle\Entity\Period",
	 * section="periods",
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
	public function postPeriodAction(Request $request)
	{
		try {
			$newPeriod = $this->container->get($this->handlerSerivce)->post($request->request->all());
			return $this->view($newPeriod, Codes::HTTP_CREATED);
		} catch (InvalidFormException $exception) {
			return $exception->getForm();
		}
	}

	/**
	 * Update existing Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * input = "Dime\EmployeeBundle\Form\Type\PeriodFormType",
	 * output = "Dime\EmployeeBundle\Entity\Period",
	 * section="periods",
	 * statusCodes = {
	 * 200 = "Returned when the Entity was updated",
	 * 400 = "Returned when the form has errors",
	 * 404 = "Returned when the Period does not exist"
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
	public function putPeriodAction(Request $request, $id)
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
	 * section="periods",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when Period does not exist."
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
	public function deletePeriodAction($id)
	{
		$this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}

	/**
	 * Enable the Period
	 *
	 * @ApiDoc(
	 * description="Enable The Period Specified by ID",
	 * resource = true,
	 * section="periods",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 */
	public function enablePeriodAction($id)
	{
		$this->container->get($this->handlerSerivce)->enable($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}

	/**
	 * Lock the Period
	 *
	 * @ApiDoc(
	 * description="Lock The Period Specified By Id",
	 * section="periods",
	 * resource = true,
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 */
	public function lockPeriodAction($id)
	{
		$this->container->get($this->handlerSerivce)->lock($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}
}
