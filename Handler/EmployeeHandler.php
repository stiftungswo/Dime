<?php
/**
 * Author: Till Wegmüller
 * Date: 10/23/14
 * Dime
 */

namespace Dime\EmployeeBundle\Handler;

use Dime\TimetrackerBundle\Handler\GenericHandler;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;

class EmployeeHandler extends GenericHandler {

	public function __construct(ObjectManager $om, $entityClass, Container $container, $alias, $formType)
	{
		parent::__construct($om, $entityClass, $container, $alias, $formType);
		$this->holidaysHandler = $this->container->get('dime.holiday.handler');
		$this->timesliceHandler = $this->container->get('dime.timeslice.handler');
		$this->holidays = $this->holidaysHandler->all();
	}

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
			$this->repository->filter($this->cleanParameterBag($params));
		}

		//Add Ordering
		$this->orderBy('id', 'ASC');
		$this->orderBy('updatedAt','ASC');

		// Pagination
		return $this->repository->getCurrentQueryBuilder()->getQuery()->getResult();
	}
}