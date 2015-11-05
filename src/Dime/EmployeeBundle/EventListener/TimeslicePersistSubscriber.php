<?php
/**
 * Author: Till Wegmüller
 * Date: 5/29/15
 * Dime
 */

namespace Dime\EmployeeBundle\EventListener;


use Carbon\Carbon;
use Dime\EmployeeBundle\Entity\Period;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\TimetrackEvents;
use Symfony\Component\DependencyInjection\ContainerAware;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class TimeslicePersistSubscriber extends ContainerAware implements EventSubscriberInterface
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
			TimetrackEvents::ENTITY_POST_PERSIST.'.PUT.Timeslice' => array(
				array('updatePeriods')
			),
			TimetrackEvents::ENTITY_POST_PERSIST.'.POST.Timeslice' => array(
				array('updatePeriodsOnPost')
			),
			TimetrackEvents::ENTITY_POST_DELETE.'.Timeslice' => array(
				array('updatePeriodsOnDelete')
			),
		);
	}

	public function updatePeriodsOnPost(DimeEntityPersistEvent $event)
	{
		return $this->updatePeriods($event, 'POST');
	}

	public function updatePeriodsOnDelete(DimeEntityPersistEvent $event)
	{
		return $this->updatePeriods($event, 'DELETE');
	}

	public function updatePeriods(DimeEntityPersistEvent $event, $method = 'PUT')
	{
		$periodHandler = $this->container->get('dime.period.handler');
		$periods = $periodHandler->all(array(
			'employee' => $event->getEntity()->getUser()->getId(),
			'timeslice' => $event->getEntity()
		));
		foreach($periods as $period) {
			if($period instanceof Period) {
				if($period->getStart() instanceof Carbon && $period->getEnd() instanceof Carbon) {
					$realTime = $period->getRealTime();
					if(strpos($method, 'PUT') !== false) {
						$timesliceHandler = $this->container->get('dime.timeslice.handler');
						$timeslice = $timesliceHandler->get($event->getEntity()->getId());
						$realTime -= $timeslice->getValue();
						$realTime += $event->getEntity()->getValue();
						$periodHandler->put($period, array('realTime' => $realTime));
					} elseif ($method == 'POST'){
						$realTime += $event->getEntity()->getValue();
						$periodHandler->put($period, array('realTime' => $realTime));
					} elseif($method == 'DELETE'){
						$realTime -= $event->getEntity()->getValue();
						$periodHandler->put($period, array('realTime' => $realTime));
					}
				}
			}
		}
		return $event;
	}
}