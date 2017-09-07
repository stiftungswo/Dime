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
use Psr\Log\LoggerInterface;

class EmployeeController extends DimeController
{

	private $handlerSerivce = 'dime.employee.handler';

	private $formType = 'dime_timetrackerbundle_employeeformtype';

	/**
	 * List all Entities.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * output = "Dime\EmployeeBundle\Entity\Employee",
	 * section="employees",
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
	 * templateVar="employees",
	 * serializerEnableMaxDepthChecks=true,
	 * serializerGroups={"List"}
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *            param fetcher service
	 *
	 * @return array
	 */
	public function getEmployeesAction(ParamFetcherInterface $paramFetcher)
	{
		$filters = $paramFetcher->all();
		$enabled = $this->getRequest()->query->get('enabled');

		if($enabled == 1) {
			$filters = array_merge($filters, array('enabled' => 1));
		}

		return $this->container->get($this->handlerSerivce)->all($filters);
	}

	/**
	 * Get single Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Gets a Employee for a given id",
	 * output = "Dime\EmployeeBundle\Entity\Employee",
	 * section="employees",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when the page is not found"
	 * }
	 * )
	 *
	 * @Annotations\View(
	 * templateVar="employee",
	 * serializerEnableMaxDepthChecks=true,
	 * serializerGroups={"List", "Default"})
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
	public function getEmployeeAction($id)
	{
		return $this->getOr404($id, $this->handlerSerivce);
	}

	/**
	 * Create a new Entity from the submitted data.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Creates a new page from the submitted data.",
	 * input = "Dime\EmployeeBundle\Form\Type\EmployeeFormType",
	 * output = "Dime\EmployeeBundle\Entity\Employee",
	 * section="employees",
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
	public function postEmployeeAction(Request $request)
	{
		try {
			$newEmployee = $this->container->get($this->handlerSerivce)->post($request->request->all());
			return $this->view($newEmployee, Codes::HTTP_CREATED);
		} catch (InvalidFormException $exception) {
			return $exception->getForm();
		}
	}

	/**
	 * Update existing Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * input = "Dime\EmployeeBundle\Form\Type\EmployeeFormType",
	 * output = "Dime\EmployeeBundle\Entity\Employee",
	 * section="employees",
	 * statusCodes = {
	 * 200 = "Returned when the Entity was updated",
	 * 400 = "Returned when the form has errors",
	 * 404 = "Returned when the Employee does not exist"
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
	public function putEmployeeAction(Request $request, $id)
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
	 * section="employees",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when Employee does not exist."
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
	public function deleteEmployeeAction($id)
	{
		$this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}

	/**
	 * Enable the Employee
	 *
	 * @ApiDoc(
	 * description="Enable The Employee Specified by ID",
	 * resource = true,
	 * section="employees",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 */
	public function enableEmployeeAction($id)
	{
		$this->container->get($this->handlerSerivce)->enable($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}

	/**
	 * Lock the Employee
	 *
	 * @ApiDoc(
	 * description="Lock The Employee Specified By Id",
	 * section="employees",
	 * resource = true,
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 */
	public function lockEmployeeAction($id)
	{
		$this->container->get($this->handlerSerivce)->lock($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}

	/**
	 * Get Curently Logged in User.
	 *
	 * @ApiDoc(
	 * description="Return the currently logged in user Object",
	 * section="users",
	 * resource = true,
	 * output = "Dime\EmployeeBundle\Entity\Employee",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when entity does not exist"
	 * }
	 * )
	 *
	 * @Annotations\Get("/employees/current", name="_curentEmployee")
	 */
	public function currentEmployeeAction()
	{
		if (! ($user = $this->container->get($this->handlerSerivce)->current())) {
			throw new NotFoundHttpException(sprintf('The resource \'%s\' was not found.', $user->getId()));
		}
		return $user;
	}
}
