<?php
/**
 * Author: Till Wegmüller
 * Date: 6/4/15
 * Dime
 */

namespace Dime\EmployeeBundle\EventListener;


use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\TimetrackEvents;
use Symfony\Component\DependencyInjection\ContainerAware;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class PeriodPersistSubscriber extends ContainerAware implements EventSubscriberInterface
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
			TimetrackEvents::ENTITY_POST_PERSIST.'.PUT.Period' => array(
				array('periodAditional')
			),
			TimetrackEvents::ENTITY_POST_PERSIST.'.POST.Period' => array(
				array('periodAditional')
			)
		);
	}

	public function periodAditional(DimeEntityPersistEvent $event)
	{
		$holidaysHandler = $this->container->get('dime.holiday.handler');
		$timesliceHandler = $this->container->get('dime.timeslice.handler');
		$om = $this->container->get('doctrine.orm.entity_manager');
		$entity = $event->getEntity();
		if($entity->getStart() instanceof \DateTime && $entity->getEnd() instanceof \DateTime) {
			$entity->setHolidays(0)->setRealTime(0);
			$entity
				->insertHolidays($holidaysHandler->all())
				->insertRealTime($timesliceHandler->all(array(
					'user' => $entity->getEmployee()->getId(),
					'date' => array(
						$entity->getStart()->toDateString(),
						$entity->getEnd()->toDateString()
					)
				)
			));
			$om->persist($entity);
			$om->flush();
		}
		return new DimeEntityPersistEvent($entity);
	}
}