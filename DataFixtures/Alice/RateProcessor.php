<?php
/**
 * Author: Till Wegmüller
 * Date: 6/2/15
 * Dime
 */

namespace Dime\TimetrackerBundle\DataFixtures\Alice;


use Money\Money;
use Nelmio\Alice\ProcessorInterface;

class RateProcessor implements ProcessorInterface {

	/**
	 * Processes an object before it is persisted to DB
	 *
	 * @param object $object instance to process
	 */
	public function preProcess($object)
	{
		if(property_exists($object, 'rateValue')){
			$object->setRateValue(Money::CHF($object->getRateValue().'.00'));
		}
	}

	/**
	 * Processes an object before it is persisted to DB
	 *
	 * @param object $object instance to process
	 */
	public function postProcess($object)
	{

	}
}