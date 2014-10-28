<?php
/**
 * Author: Till Wegmüller
 * Date: 10/23/14
 * Dime
 */

namespace Dime\TimetrackerBundle\Handler;


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

		// Scope by current user if the User is not set in the Filter Array
		if(!isset($params['user'])) {
			$this->repository->scopeByField('user', $this->getCurrentUser()->getId());
		}

		//Add Ordering
		$this->orderBy('updatedAt','DESC');
		$this->orderBy('id', 'DESC');

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
		if(!isset($parameters['user'])) {
			$parameters['user'] = $this->getCurrentUser()->getId();
		}
		return $this->processForm($entity, $parameters, $this->formType, 'POST');
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
		if(!isset($parameters['user'])) {
			$parameters['user'] = $this->getCurrentUser()->getId();
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
}