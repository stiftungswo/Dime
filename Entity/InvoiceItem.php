<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;


use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Model\RateUnitType;

class InvoiceItem {
	public $type;
	public $rate;
	public $value;
	public $rateUnit;
	public $charge;

	public function __construct(Activity $activity)
	{
		$this->type     = $activity->getService()->getName();
		$this->rate     = $activity->getRate();
		$this->value   = $activity->getValue();
		$this->rateUnit = $activity->getService()->getRateByRateGroup($activity->getProject()->getRateGroup())->getRateUnit();
		$this->rateUnitType = $activity->getService()->getRateByRateGroup($activity->getProject()->getRateGroup())->getRateUnitType();
		switch($this->rateUnitType){
		case RateUnitType::$Hourly:
			$this->value = ($this->value / 3600);
			break;
		case RateUnitType::$Minutely:
			$this->value = ($this->value / 60);
			break;
		case RateUnitType::$Dayly:
			$this->value = ($this->value / 86400);
			break;
		}
		$this->charge = ceil($this->rate * $this->value);
	}
} 