<?php
/**
 * Author: Till Wegmüller
 * Date: 6/2/15
 * Dime
 */

namespace Dime\TimetrackerBundle\DataFixtures\Alice;


use Carbon\Carbon;
use Dime\EmployeeBundle\Entity\Period;
use Dime\TimetrackerBundle\Entity\RateUnitType;
use Money\Money;
use Nelmio\Alice\ProcessorInterface;

class Processor implements ProcessorInterface {

	/**
	 * Processes an object before it is persisted to DB
	 *
	 * @param object $object instance to process
	 */
	public function preProcess($object)
	{
		if(property_exists($object, 'rateValue')){
			if(!is_null($object->getRateValue()) && !$object->getRateValue() instanceof Money) {
				$object->setRateValue(Money::CHF($object->getRateValue() . '.00'));
			}
		}
		if(property_exists($object, 'total')){
			if(!is_null($object->getTotal()) && !$object->getTotal() instanceof Money) {
				$object->setTotal(Money::CHF($object->getTotal() . '.00'));
			}
		}
		if(property_exists($object, 'budgetPrice')){
			if(!is_null($object->getBudgetPrice()) && !$object->getBudgetPrice() instanceof Money) {
				$object->setBudgetPrice(Money::CHF($object->getBudgetPrice() . '.00'));
			}
		}
		if(property_exists($object, 'fixedPrice')){
			if(!is_null($object->getFixedPrice()) && !$object->getFixedPrice() instanceof Money) {
				$object->setFixedPrice(Money::CHF($object->getFixedPrice() . '.00'));
			}
		}
        if($object instanceof Period) {
            if($object->getPensum() && $object->getStart() instanceof Carbon && $object->getEmployee()->getEmployeeholiday() != null) {

                $pensum = ($object->getPensum());
                $holidayEntitlement = $object->getEmployee()->getEmployeeholiday();
                $weekdays = ($object->getStart()->diffInDays($object->getEnd()->addDay()));

                $holidaysInSeconds = (($holidayEntitlement / 365) * $weekdays * $pensum) * RateUnitType::$DayInSeconds;

                $object->setHolidays($holidaysInSeconds);
            }
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