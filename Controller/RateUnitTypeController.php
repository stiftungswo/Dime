<?php
/**
 * Author: Till Wegmüller
 * Date: 11/14/14
 * Dime
 */

namespace Dime\TimetrackerBundle\Controller;

use Dime\TimetrackerBundle\Model\RateUnitType;
use FOS\RestBundle\Controller\Annotations;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class RateUnitTypeController extends DimeController
{
	/**
	 * List all Entities.
	 *
	 * @ApiDoc(
	 * resource = true,
	 * output = "Dime\TimetrackerBundle\Model\RateUnittype",
	 * description="Gets a Collection of RateUnitTypes, RateUnitTypes are Application internal Constants",
	 * section="rateUnitTypes",
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\View(
	 * templateVar="ratesunittypes"
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 * @Annotations\Get("/rateunittypes", name="_rateunittypes")
	 *
	 * @return array
	 *
	 */
	public function getRateUnitTypesAction()
	{
		$retval = array();
		foreach(RateUnitType::ChoiceList() as $value => $choice)
		{
			$retval[] = array('id' => $value, 'name' => $choice);
		}
		return $retval;
	}

	/**
	 * Get single Entity
	 *
	 * @ApiDoc(
	 * resource = true,
	 * description = "Gets a RateUnitType for a given id",
	 * output = "Dime\TimetrackerBundle\Model\RateUnittype",
	 * section="rateUnitTypes",
	 * statusCodes = {
	 * 200 = "Returned when successful",
	 * 404 = "Returned when the page is not found"
	 * }
	 * )
	 *
	 * @Annotations\View(templateVar="rateunittype")
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @Annotations\Get("/rateunittypes/{id}", name="_rateunittypes")

	 * @param int $id
	 *            the entity id
	 *
	 * @return array
	 *
	 * @throws NotFoundHttpException when page not exist
	 */
	public function getRateUnitTypeAction($id)
	{
		return array('id' => $id, 'name' => RateUnitType::ChoiceList()[$id]);
	}
} 