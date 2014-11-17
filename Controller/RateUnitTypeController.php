<?php
/**
 * Author: Till Wegmüller
 * Date: 11/14/14
 * Dime
 */

namespace Dime\TimetrackerBundle\Controller;

use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Dime\TimetrackerBundle\Model\RateUnitType;

class RateUnitTypeController extends DimeController
{
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
	 * description = "Gets a RateGroup for a given id",
	 * output = "Dime\TimetrackerBundle\Entity\RateGroup",
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
	public function getRateGroupAction($id)
	{
		return array('id' => $id, 'name' => RateUnitType::ChoiceList()[$id]);
	}
} 