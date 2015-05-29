<?php
/**
 * Author: Till Wegmüller
 * Date: 10/23/14
 * Dime
 */

namespace Dime\EmployeeBundle\Handler;

use Dime\EmployeeBundle\Entity\Period;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Handler\GenericHandler;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\TimetrackEvents;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\DependencyInjection\Container;

class PeriodHandler extends GenericHandler {

	protected $holidaysHandler;

	protected $timesliceHandler;

	public function __construct(ObjectManager $om, $entityClass, Container $container, $alias, $formType)
	{
		parent::__construct($om, $entityClass, $container, $alias, $formType);
		$this->holidaysHandler = $this->container->get('dime.holiday.handler');
		$this->timesliceHandler = $this->container->get('dime.timeslice.handler');
	}

	/**
	 * Processes the form.
	 *
	 * @param Period $entity
	 * @param array               $parameters
	 * @param                     $form
	 * @param String              $method
	 *
	 *
	 * @param array               $formoptions
	 *
	 * @return \Dime\EmployeeBundle\Entity\Period
	 */
	protected function processForm(DimeEntityInterface $entity, array $parameters, $form, $method = "PUT", $formoptions = array())
	{
		$formoptions['method'] = $method;
		$form = $this->formFactory->create($form, $entity, $formoptions);
		$form->submit($parameters, 'PUT' !== $method);
		if ($form->isValid()) {
			$entity = $form->getData();
			$refclas = new \ReflectionClass($this->entityClass);
			$this->eventDispatcher->dispatch(TimetrackEvents::ENTITY_PRE_PERSIST.'.'.$method.'.'.$refclas->getShortName(), new DimeEntityPersistEvent($entity));
			$this->om->persist($entity);
			$this->om->flush();
			$entity->insertHolidays($this->holidaysHandler->all())->insertRealTime($timeslices = $this->timesliceHandler->all(array(
					'user' => $entity->getEmployee()->getId(),
					'date' => array(
						$entity->getStart()->toDateString(),
						$entity->getEnd()->toDateString()
					)
				)
			));
			$this->om->persist($entity);
			$this->om->flush();
			$this->eventDispatcher->dispatch(TimetrackEvents::ENTITY_POST_PERSIST.'.'.$method.'.'.$refclas->getShortName(), new DimeEntityPersistEvent($entity));
			return $entity;
		}
		throw new InvalidFormException('Invalid submitted data', $form);
	}
}