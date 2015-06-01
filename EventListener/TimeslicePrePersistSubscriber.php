<?php
/**
 * Author: Till Wegmüller
 * Date: 5/29/15
 * Dime
 */

namespace Dime\EmployeeBundle\EventListener;


use Dime\EmployeeBundle\Entity\Period;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\TimetrackEvents;
use Symfony\Component\DependencyInjection\ContainerAware;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class TimeslicePrePersistSubscriber extends ContainerAware implements EventSubscriberInterface
{

	/**
	 * Returns an array of event names this subscriber wants to listen to.
	 *
	 * The array keys are event names and the value can be:
	 *
	 *  * The method name to call (priority defaults to 0)
	 *  * An array composed of the method name to call and the priority
	 *  * An array of arrays composed of the method names to call and respective
	 *    priorities, or 0 if unset
	 *
	 * For instance:
	 *
	 *  * array('eventName' => 'methodName')
	 *  * array('eventName' => array('methodName', $priority))
	 *  * array('eventName' => array(array('methodName1', $priority), array('methodName2'))
	 *
	 * @return array The event names to listen to
	 *
	 * @api
	 */
	public static function getSubscribedEvents()
	{
		return array(
			TimetrackEvents::ENTITY_PRE_PERSIST.'.PUT.Timeslice' => array(
				array('updatePeriods')
			),
			TimetrackEvents::ENTITY_PRE_PERSIST.'.POST.Timeslice' => array(
				array('updatePeriodsOnPost')
			)
		);
	}

	public function updatePeriodsOnPost(DimeEntityPersistEvent $event)
	{
		return $this->updatePeriods($event, 'POST');
	}

	public function updatePeriods(DimeEntityPersistEvent $event, $method = 'PUT')
	{
		$periodHandler = $this->container->get('dime.period.handler');
		$arr = $periodHandler->all(array(
			'employee' => $event->getEntity()->getUser()->getId(),
			'timeslice' => $event->getEntity()
		));
		$period = array_shift($arr);
		if($period instanceof Period) {
			$realTime = $period->getRealTime();
			if($method == 'PUT') {
				$timesliceHandler = $this->container->get('dime.timeslice.handler');
				$timeslice        = $timesliceHandler->get($event->getEntity()->getId());
				$realTime -= $timeslice->getValue();
			}
			$realTime += $event->getEntity()->getValue();
			$this->container->get('dime.period.handler')->put($period, array('realTime' => $realTime));

		}
		return $event;
	}
}