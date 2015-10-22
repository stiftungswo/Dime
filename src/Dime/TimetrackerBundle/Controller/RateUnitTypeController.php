<?php
/**
 * Author: Till Wegmüller
 * Date: 11/14/14
 * Dime
 */

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

class RateUnitTypeController extends DimeController
{
	private $handlerSerivce = 'dime.rateunittype.handler';

	private $formType = 'dime_timetrackerbundle_rateunittypeformtype';

	/**
	 * List all Entities.
	 *
	 * @ApiDoc(
	 *  description = "Get Collection of Rateunittypes",
	 *  section = "rateunittypes",
	 *  output = "Dime\TimetrackerBundle\Entity\RateUnitType",
	 *  statusCodes = {
	 *      200 = "Returned when successful",
	 *      405 = "Returned on Unsupported Method",
	 *      500 = "Returned on Error"
	 *  }
	 * )
	 *
	 * @Annotations\QueryParam(name="name", nullable=true, description="Filter on Name Property")
	 *
	 * @Annotations\View(
	 * serializerEnableMaxDepthChecks=true
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *            param fetcher activity
	 *
	 * @return array
	 */
	public function getRateunittypesAction(ParamFetcherInterface $paramFetcher)
	{
		return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
	}

	/**
	 * Get single Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Gets a Rateunittype for a given id",
	 * output = "Dime\TimetrackerBundle\Entity\RateUnitType",
	 * section = "rateunittypes",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when the page is not found",
	 * 405 = "Returned on Unsupported Method",
	 * 500 = "Returned on Error"
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
	public function getRateunittypeAction($id)
	{
		return $this->getOr404($id, $this->handlerSerivce);
	}

	/**
	 * Create a new Entity from the submitted data.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Creates a new activity from the submitted data.",
	 * input = "Dime\TimetrackerBundle\Form\Type\RateUnitTypeFormType",
	 * output = "Dime\TimetrackerBundle\Entity\RateUnitType",
	 * section = "rateunittypes",
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
	public function postRateunittypeAction(Request $request)
	{
		try {
			$newRateunittype = $this->container->get($this->handlerSerivce)->post($request->request->all());
			return $this->view($newRateunittype, Codes::HTTP_CREATED);
		} catch (InvalidFormException $exception) {
			return $exception->getForm();
		}
	}

	/**
	 * Update existing Entity.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * input = "Dime\TimetrackerBundle\Form\Type\RateUnitTypeFormType",
	 * output = "Dime\TimetrackerBundle\Entity\RateUnitType",
	 * section = "rateunittypes",
	 * description="Update Rateunittype Data of Given Id",
	 * statusCodes = {
	 * 200 = "Returned when the Entity was updated",
	 * 400 = "Returned when the form has errors",
	 * 404 = "Returned when the Rateunittype does not exist"
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
	public function putRateunittypeAction(Request $request, $id)
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
	 * section = "rateunittypes",
	 * statusCodes = {
	 * 204 = "Returned when successful",
	 * 404 = "Returned when Rateunittype does not exist."
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
	public function deleteRateunittypeAction($id)
	{
		$this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
		return $this->view(null, Codes::HTTP_NO_CONTENT);
	}
} 