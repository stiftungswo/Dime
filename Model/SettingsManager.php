<?php
/**
 * Author: Till Wegmüller
 * Date: 1/14/15
 * Dime
 * Wrapper Class Around Settings Handler Allowing the Execution of Code Based on Rules
 */

namespace Dime\TimetrackerBundle\Model;

use Dime\TimetrackerBundle\Entity\Setting;
use Dime\TimetrackerBundle\Event\ResolveSettingEvent;
use Dime\TimetrackerBundle\TimetrackEvents;
use Symfony\Component\DependencyInjection\ContainerAware;

class SettingsManager extends ContainerAware implements HandlerInterface
{

	protected $handler = 'dime.setting.handler';

	protected $resolve = true;

	protected $paramList = array('resolve');

	protected $classname = '';

	/**
	 * Get a Entity given the identifier
	 *
	 * @api
	 *
	 * @param mixed $id
	 *
	 * @return DimeEntityInterface
	 */
	public function get($id)
	{
		return $this->container->get($this->handler)->get($id);
	}

	/**
	 * Get a list of Entities.
	 *
	 * @param array $filterparams
	 * @param array $resolveparams
	 *
	 * @return array
	 *
	 */
	public function all($filterparams = array(), $resolveparams = array())
	{
		$this->classname = $resolveparams['classname'];
		$settings = $this->container->get($this->handler)->all($filterparams);
		$retval = array();
		foreach($settings as $setting)
		{
			$retval[] = $this->resolve($setting, $resolveparams);
		}
		return $retval;
	}

	/**
	 * Post Entity, creates a new Entity.
	 *
	 * @api
	 *
	 * @param array $parameters
	 *
	 * @return DimeEntityInterface
	 *
	 */
	public function post(array $parameters)
	{
		return $this->container->get($this->handler)->post($parameters);
	}

	/**
	 * Replace data of a Entity.
	 *
	 * @api
	 *
	 * @param DimeEntityInterface $entity
	 * @param array               $parameters
	 *
	 * @return DimeEntityInterface
	 */
	public function put(DimeEntityInterface $entity, array $parameters)
	{
		return $this->container->get($this->handler)->put($entity, $parameters);
	}

	/**
	 * Delete an Entity
	 *
	 * @api
	 *
	 * @param DimeEntityInterface $entity
	 *
	 */
	public function delete(DimeEntityInterface $entity)
	{
		$this->container->get($this->handler)->delete($entity);
	}

	protected function parseParams($params)
	{
		foreach($this->paramList as $param) {
			if(isset($params[$param])) {
				$this->$param = $params[$param];
				unset($params[$param]);
			}
		}
		return $params;
	}

	protected function resolve($setting, array $parameters)
	{
		if($this->resolve)
		{
			if(strpos($setting->getValue(), 'action:') !== false)
			{
				$eventDispatcher = $this->container->get('event_dispatcher');
				$values = explode(':', $setting->getValue());
				$eventname = TimetrackEvents::SETTING_RESOLVE.'.'.$this->classname.'.'.$setting->getName().'.'.$values[1];
				$retval = $eventDispatcher->dispatch($eventname, new ResolveSettingEvent($setting, $parameters))->getSetting();
				return $retval;
			}
		}
		return $setting;
	}

	/**
	 * @param Setting             $setting
	 * @param DimeEntityInterface $entity
	 *
	 * @return DimeEntityInterface
	 */
	public function applySetting(Setting $setting, DimeEntityInterface $entity)
	{
		$functionName = 'set' . ucfirst($setting->getName());
		if(is_callable(array($entity, $functionName))){
			$entity->$functionName($setting->getValue());
		}
		return $entity;
	}

	/**
	 * Duplicates an Entity
	 *
	 * @api
	 *
	 * @param DimeEntityInterface $entity
	 *
	 * @return DimeEntityInterface
	 */
	public function duplicate(DimeEntityInterface $entity)
	{
		// TODO: Implement duplicate() method.
	}
}