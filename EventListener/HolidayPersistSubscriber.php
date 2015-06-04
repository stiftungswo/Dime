<?php
/**
 * Author: Till Wegmüller
 * Date: 6/4/15
 * Dime
 */

namespace Dime\EmployeeBundle\EventListener;


use Dime\EmployeeBundle\Entity\Period;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\TimetrackEvents;
use Symfony\Component\DependencyInjection\ContainerAware;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class HolidayPersistSubscriber extends ContainerAware implements EventSubscriberInterface
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
			TimetrackEvents::ENTITY_POST_PERSIST.'.PUT.Holiday' => array(
				array('periodAditional')
			),
			TimetrackEvents::ENTITY_POST_PERSIST.'.POST.Holiday' => array(
				array('periodAditional')
			),
			TimetrackEvents::ENTITY_POST_DELETE.'.Holiday' => array(
				array('periodOnHolidayDelete')
			),
		);
	}

	public function periodOnHolidayDelete(DimeEntityPersistEvent $event)
	{
		$this->periodAditional($event, 'DELETE');
	}

	public function periodAditional(DimeEntityPersistEvent $event, $method = 'PUT')
	{
		$om = $this->container->get('doctrine.orm.entity_manager');
		$periodHandler = $this->container->get('dime.period.handler');
		$periods = $periodHandler->all(array(
			'holiday' => $event->getEntity()
		));
		foreach($periods as $period) {
			if($period instanceof Period) {
				if($period->getStart() instanceof \DateTime && $period->getEnd() instanceof \DateTime) {
					if($method == 'DELETE'){
						$period->removeHolidays(array($event->getEntity()));
					} else {
						$period->insertHolidays(array($event->getEntity()));
					}
					$om->persist($period);
				}
			}
		}
		$om->flush();
		return $event;
	}
}