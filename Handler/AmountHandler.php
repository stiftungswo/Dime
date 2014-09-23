<?php
/**
 * Created by PhpStorm.
 * User: toast
 * Date: 9/19/14
 * Time: 12:05 PM
 */

namespace Dime\TimetrackerBundle\Handler;


use Dime\TimetrackerBundle\Entity\Amount;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Model\ActivityReference;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Model\HandlerInterface;

class AmountHandler extends AbstractHandler implements HandlerInterface {

	private $formType = 'dime_timetrackerbundle_amountformtype';
	/**
	 * @var array allowed filter keys
	 */
	protected $allowed_filter = array(
		'date',
		'active',
		'customer',
		'project',
		'service',
		'user',
		'withTags',
		'withoutTags',
		'value'
	);

	public function all($limit = 5, $offset = 0, $filter = array())
	{
		$this->repository->createCurrentQueryBuilder('am');

		// Filter
		if ($filter) {
			$this->repository->filter($this->cleanFilter($filter, $this->allowed_filter));
		}

		// Scope by current user
		if (!isset($filter['user'])) {
			$this->repository->scopeByField('user', $this->getCurrentUser()->getId());
		}

		$this->repository->getCurrentQueryBuilder()->addOrderBy('am.updatedAt', 'DESC');
		$this->repository->getCurrentQueryBuilder()->addOrderBy('am.id', 'DESC');

		// Pagination
		return $this->repository->findBy(array(), null, $limit, $offset);
	}

	/**
	 * (non-PHPdoc)
	 * @see \Dime\TimetrackerBundle\Model\HandlerInterface::get()
	 */
	public function get($id)
	{
		return $this->repository->find($id);
	}

	/*
	 * (non-PHPdoc)
	 * @see \Dime\TimetrackerBundle\Model\HandlerInterface::post()
	 */
	public function post(array $parameters)
	{
		$entity = $this->newClassInstance();
		if (!isset($parameters['user']))
		{
			$parameters['user'] = $this->getCurrentUser()->getId();
		}
		return $this->processForm($entity, $parameters, $this->formType,'POST');
	}

	/*
	 * (non-PHPdoc)
	 * @see \Dime\TimetrackerBundle\Model\HandlerInterface::put()
	 */
	public function put(DimeEntityInterface $entity, array $parameters)
	{
		if (!isset($parameters['user']))
		{
			$parameters['user'] = $this->getCurrentUser()->getId();
		}
		return $this->processForm($entity, $parameters, $this->formType, 'PUT');
	}

	/*
	 * (non-PHPdoc)
	 * @see \Dime\TimetrackerBundle\Model\HandlerInterface::delete()
	 */
	public function delete(DimeEntityInterface $entity)
	{
		$this->deleteEntity($entity);
	}
}