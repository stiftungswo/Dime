<?php
/**
 * Author: Till Wegmüller
 * Date: 10/23/14
 * Dime
 */

namespace Dime\TimetrackerBundle\Handler;


use DeepCopy\DeepCopy;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Model\HandlerInterface;

class GenericHandler extends AbstractHandler implements HandlerInterface {

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
		return $this->repository->find($id);
	}

	/**
	 * Get a list of Entities.
	 *
	 * @param array $params The Parameters from the ParamFetcherInterface
	 *
	 * @return array
	 */
	public function all($params = array())
	{
		$this->repository->createCurrentQueryBuilder($this->alias);


		// Filter
		if($this->hasParams($params)) {
			$this->repository->filter($this->cleanFilter($params));
		}

		//Add Ordering
		$this->orderBy('id', 'ASC');
		$this->orderBy('updatedAt','ASC');

		// Pagination
		return $this->repository->getCurrentQueryBuilder()->getQuery()->getResult();
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
		$entity = $this->newClassInstance();
		if(isset($parameters['id'])){
			unset($parameters['id']);
		}
		return $this->processForm($entity, $parameters, $this->formType, 'POST');
	}

	/**
	 * Returns a new valid Entity
	 *
	 *
	 * @param array $parameters
	 *
	 * @param array $settingsParams
	 *
	 * @return mixed
	 *
	 */
	public function newEntity(array $parameters, array $settingsParams)
	{
		if(!isset($settingsParams['user'])) {
			$settingsParams['user'] = $this->getCurrentUser()->getId();
		}
		$settings = $this->fillFromSettings($settingsParams);
		$parameters = $this->cleanFilter($parameters);
		foreach($parameters as $key => $value)
		{
			$settings[$key] = $value;
		}
		return $this->post($settings);
	}

	protected function fillFromSettings(array $parameters)
	{
		$settingsManager = $this->container->get('dime.setting.manager');
		$parameters = $this->cleanFilter($parameters);
		$systemSettings = $settingsManager->all(
			array(
				'namespace' => '/etc/defaults/'.$parameters['classname']
			),
			$parameters
		);
		$userSettings = $settingsManager->all(
			array(
				'namespace' => '/usr/defaults/'.$parameters['classname'],
				'user' => $parameters['user']
			),
			$parameters
		);
		$retval = array();
		foreach($systemSettings as $systemSetting)
		{
			$retval[$systemSetting->getName()] = $systemSetting->getValue();
		}
		foreach($userSettings as $userSetting)
		{
			$retval[$userSetting->getName()] = $userSetting->getValue();
		}
		return $retval;
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
		if(isset($parameters['id'])){
			unset($parameters['id']);
		}
		return $this->processForm($entity, $parameters, $this->formType, 'PUT');
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
		$this->deleteEntity($entity);
	}

	/**
	 * Duplicate an Entity
	 * @param DimeEntityInterface $entity
	 *
	 * @return mixed
	 */
	public function duplicate(DimeEntityInterface $entity)
	{
		$deepCopy = new DeepCopy();
		$deepCopy = $entity::getCopyFilters($deepCopy);
		$newEntity = $deepCopy->copy($entity);
		$this->om->persist($newEntity);
		$this->om->flush();
		return $newEntity;
	}
}