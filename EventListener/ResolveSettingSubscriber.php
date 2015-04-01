<?php
/**
 * Author: Till Wegmüller
 * Date: 1/14/15
 * Dime
 */

namespace Dime\TimetrackerBundle\EventListener;


use Carbon\Carbon;
use Dime\TimetrackerBundle\Event\ResolveSettingEvent;
use Dime\TimetrackerBundle\TimetrackEvents;
use Symfony\Component\DependencyInjection\ContainerAware;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class ResolveSettingSubscriber extends ContainerAware implements EventSubscriberInterface
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
			TimetrackEvents::SETTING_RESOLVE.'.timeslice.startedAt.nextDate' => array(
				array('resolveTimesliceStartedAtNextDate')
			),
			TimetrackEvents::SETTING_RESOLVE.'.timeslice.activity.byName' => array(
				array('resolveTimesliceActivityByName')
			)
		);
	}

	/**
	 * Get the Next Workday after the last timeslice of the User
	 * @param ResolveSettingEvent $event
	 *
	 * @return ResolveSettingEvent
	 */
	public function resolveTimesliceStartedAtNextDate(ResolveSettingEvent $event)
	{
		$parameters = $event->getParameters();
		$setting = $event->getSetting();
		$handler = $this->container->get('dime.timeslice.handler');
		$timeslices = $handler->all(array('user' => $parameters['user'], 'latest' => true));
		$lasttimeslice = array_shift($timeslices);
		if($lasttimeslice) {
			$newDate = Carbon::instance($lasttimeslice->getStartedAt());
			if(strpos($setting->getValue(), 'ignoreWeekend') !== false) {
				$newDate->addDay();
			} else {
				switch($newDate->dayOfWeek) {
				case 5:
					$newDate->addDays(3);
					break;
				case 6:
					$newDate->addDays(2);
					break;
				default:
					$newDate->addDay();
					break;
				}
			}
		} else {
			$newDate = Carbon::now();
		}
		$setting->setValue(date_format($newDate, 'Y-m-d'));
		return new ResolveSettingEvent($setting, $parameters);
	}

	/**
	 * Get a activity who's name is like $setting->value
	 * @param ResolveSettingEvent $event
	 *
	 * @return ResolveSettingEvent
	 */
	public function resolveTimesliceActivityByName(ResolveSettingEvent $event)
	{
		$parameters = $event->getParameters();
		$setting = $event->getSetting();
		$activityString = explode(':', $setting->getValue())[2];

		$handler = $this->container->get('dime.activity.handler');
		$activities = $handler->all(array('project' => $parameters['project'], 'name' => $activityString));
		$activity = array_shift($activities);
		$setting->setValue($activity->getId());
		return new ResolveSettingEvent($setting, $parameters);
	}
}