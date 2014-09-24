<?php
/**
 * Author: Till Wegmüller
 * Date: 9/24/14
 * Dime
 */

namespace Dime\InvoiceBundle\Entity;


use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Amount;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;

class InvoiceItem {
	public $rate;
	public $amount;
	public $rateUnit;
	public $charge;

	public function __construct(DimeEntityInterface $entity)
	{
		if($entity instanceof Activity) {
			$this->rate     = $entity->getRate();
			$this->amount   = $entity->getDuration();
			$this->rateUnit = $entity->getService()->getRateUnit();
			$this->charge   = ($entity->getRate() * $entity->getDuration());
		} elseif($entity instanceof Amount) {
			$this->rate     = $entity->getRate();
			$this->amount   = $entity->getValue();
			$this->rateUnit = $entity->getService()->getRateUnit();
			$this->charge   = ($entity->getRate() * $entity->getValue());
		}
	}
} 