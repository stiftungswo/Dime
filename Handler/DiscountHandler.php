<?php
/**
 * Author: Till Wegmüller
 * Date: 9/26/14
 * Dime
 */

namespace Dime\InvoiceBundle\Handler;


use Dime\TimetrackerBundle\Handler\AbstractHandler;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Model\HandlerInterface;

class DiscountHandler extends AbstractHandler implements HandlerInterface
{
	private $formType = 'dime_invoicebundle_discountformtype';
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
	 * @param array $params
	 *
	 *
	 * @return array
	 */
	public function all($params = array())
	{
		return $this->repository->findBy($params);
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
		return $this->processForm($this->newClassInstance(), $parameters, $this->formType, 'POST');
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