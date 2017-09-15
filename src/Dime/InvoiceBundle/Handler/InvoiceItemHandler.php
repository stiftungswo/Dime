<?php
/**
 * Author: Michael Schär
 * Date: 9/14/17
 */

namespace Dime\InvoiceBundle\Handler;

use Carbon\Carbon;
use Dime\InvoiceBundle\Entity\Invoice;
use Dime\InvoiceBundle\Entity\InvoiceDiscount;
use Dime\InvoiceBundle\Entity\InvoiceItem;
use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Handler\GenericHandler;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\TimetrackEvents;
use Dime\TimetrackerBundle\Model\DimeEntityInterface as DEInterface;

class InvoiceItemHandler extends GenericHandler
{
    /**
    * Overrides AbstractHandler -> processForm
    */
    protected function processForm(DEInterface $entity, array $parameters, $form, $method = "PUT", $formoptions = array())
    {
        $formoptions['method'] = $method;
        $form = $this->formFactory->create($form, $entity, $formoptions);
        $form->submit($parameters, 'PUT' !== $method);
        if ($form->isValid()) {
            $entity = $form->getData();
          // FIXME this is a hack for inserting the activityId when ignored by the formFactory.
          // Better solution: fix the formfactory and delete this function
          // Used in InvoiceItemController -> postInvoiceItemAction
            if (isset($parameters['activity'])) {
                $entity->setActivity($this->om->getReference('Dime\TimetrackerBundle\Entity\Activity', $parameters['activity']));
            }
            $refclas = new \ReflectionClass($this->entityClass);
            $this->eventDispatcher->dispatch(TimetrackEvents::ENTITY_PRE_PERSIST.'.'.$method.'.'.$refclas->getShortName(), new DimeEntityPersistEvent($entity));
            $this->om->persist($entity);
            $this->om->flush();
            $this->eventDispatcher->dispatch(TimetrackEvents::ENTITY_POST_PERSIST.'.'.$method.'.'.$refclas->getShortName(), new DimeEntityPersistEvent($entity));
            return $entity;
        }
        throw new InvalidFormException('Invalid submitted data', $form);
    }
}
