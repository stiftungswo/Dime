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

class HolidayController extends DimeController
{

	private $handlerSerivce = 'dime.holiday.handler';

	private $formType = 'dime_timetrackerbundle_holidayformtype';

	/**
	 * List all Entities.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * output = "Dime\EmployeeBundle\Entity\Holiday",
	 * section="holidays",
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
	 * templateVar="holidays"
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *            param fetcher service
	 *
	 * @return array
	 */
	public function getHolidaysAction(ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
	}

	/**
	 * Get single Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Gets a Holiday for a given id",
	 * output = "Dime\EmployeeBundle\Entity\Holiday",
	 * section="holidays",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when the page is not found"
	 * }
	 * )
	 *
	 * @Annotations\View(templateVar="holiday")
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
	public function getHolidayAction($id)
	{
		return $this->getOr404($id, $this->handlerSerivce);
	}

	/**
	 * Create a new Entity from the submitted data.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Creates a new page from the submitted data.",
	 * input = "Dime\EmployeeBundle\Form\Type\HolidayFormType",
	 * output = "Dime\EmployeeBundle\Entity\Holiday",
	 * section="holidays",
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
	public function postHolidayAction(Request $request)
	{
		try {
			$newHoliday = $this->container->get($this->handlerSerivce)->post($request->request->all());
			return $this->view($newHoliday, Codes::HTTP_CREATED);
		} catch (InvalidFormException $exception) {
			return $exception->getForm();
		}
	}

	/**
	 * Update existing Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * input = "Dime\EmployeeBundle\Form\Type\HolidayFormType",
	 * output = "Dime\EmployeeBundle\Entity\Holiday",
	 * section="holidays",
	 * statusCodes = {
	 * 200 = "Returned when the Entity was updated",
	 * 400 = "Returned when the form has errors",
	 * 404 = "Returned when the Holiday does not exist"
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
	public function putHolidayAction(Request $request, $id)
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
	 * section="holidays",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when Holiday does not exist."
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
	public function deleteHolidayAction($id)
	{
		$this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}
}
