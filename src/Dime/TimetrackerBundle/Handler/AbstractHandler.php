<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\TimetrackEvents;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\DependencyInjection\Container;

abstract class AbstractHandler
{

    protected $om;

    protected $entityClass;

    protected $repository;

    protected $formFactory;
    
    protected $secContext;

    protected $alias;

    protected $formType;

    protected $container;

    protected $eventDispatcher;

    public function __construct(ObjectManager $om, $entityClass, Container $container, $alias, $formType)
    {
        $this->om = $om;
        $this->entityClass = $entityClass;
        $this->repository = $this->om->getRepository($this->entityClass);
        $this->formFactory = $container->get('form.factory');
        $this->secContext = $container->get('security.context');
        $this->eventDispatcher = $container->get('event_dispatcher');
        $this->container = $container;
        $this->alias = $alias;
        $this->formType = $formType;
    }

    protected function newClassInstance()
    {
        return new $this->entityClass();
    }

    protected function orderBy($field, $order)
    {
        $this->repository->getCurrentQueryBuilder()->addOrderBy($this->alias.'.'.$field, $order);
    }

    function cleanNULL(array $parameters)
    {
        foreach ($parameters as $key => $value) {
            if ($value === null) {
                unset($parameters[$key]);
            }
        }
        return $parameters;
    }

    protected function flattenEtityReference(array $parameters)
    {
        foreach ($parameters as $key => $param) {
            if (is_array($param) && count($param) === 1 && isset($param['id'])) {
                $parameters[$key] = $param['id'];
            }
        }
        return $parameters;
    }

    /**
     * Processes the form.
     *
     * @param DimeEntityInterface $entity
     * @param array               $parameters
     * @param                     $form
     * @param String              $method
     *
     *
     * @param array               $formoptions
     *
     * @return \Dime\TimetrackerBundle\Model\DimeEntityInterface|mixed
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
            $this->eventDispatcher->dispatch(TimetrackEvents::ENTITY_POST_PERSIST.'.'.$method.'.'.$refclas->getShortName(), new DimeEntityPersistEvent($entity));
            return $entity;
        }
        throw new InvalidFormException('Invalid submitted data', $form);
    }

    /**
     * Make a Form from an Entity
     *
     * @param DimeEntityInterface $entity
     * @param                     $formtype
     * @param array               $values
     * @param array               $formoptions
     *
     * @return \Symfony\Component\Form\FormInterface
     */
    protected function createForm(DimeEntityInterface $entity, $formtype, array $values, $formoptions = array())
    {
        $form = $this->formFactory->create($formtype, $entity, $formoptions);
        $form->submit($values, true);
        return $form;
    }

    /**
     * Remove The Entity From Database.
     * @param DimeEntityInterface $entity
     */
    protected function deleteEntity(DimeEntityInterface $entity)
    {
        $refclas = new \ReflectionClass($this->entityClass);
        $this->eventDispatcher->dispatch(TimetrackEvents::ENTITY_PRE_DELETE.'.'.$refclas->getShortName(), new DimeEntityPersistEvent($entity));
        $this->om->remove($entity);
        $this->om->flush();
        $this->eventDispatcher->dispatch(TimetrackEvents::ENTITY_POST_DELETE.'.'.$refclas->getShortName(), new DimeEntityPersistEvent($entity));
    }

    /**
     * Clean up filter array
     *
     * @param array $filter
     *
     * @param       $keepemptyArrays
     *
     * @return array $result
     */
    protected function cleanParameterBag(array $filter, $keepemptyArrays = true)
    {
        $result = array();
        foreach ($filter as $key => $value) {
            if (is_array($value)) {
                if (empty($value)) {
                    if ($keepemptyArrays === true) {
                        $value = $this->cleanParameterBag($value, $keepemptyArrays);
                    } else {
                        $value = null;
                    }
                } else {
                    $value = $this->cleanParameterBag($value, $keepemptyArrays);
                }
                if (isset($value['id'])) {
                    $value = $value['id'];
                }
            }
            if ($value===false) {
                $result[$key]='0';
            }
            if ($value===true) {
                $result[$key]='1';
            }
            if (isset($value)) {
                $result[$key]=$value;
            }
        }
        return $result;
    }

    /**
     * @param array $params
     *
     * @return bool
     */
    protected function hasParams(array $params)
    {
        foreach ($params as $param) {
            if (!empty($param)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * Get the current user
     *
     * @return \Dime\TimetrackerBundle\Entity\User
     */
    protected function getCurrentUser()
    {
        $user = $this->secContext->getToken()->getUser();
        if (!is_object($user) || !$user instanceof \Symfony\Component\Security\Core\User\UserInterface) {
            throw new \Symfony\Component\Security\Core\Exception\AccessDeniedException(
                'This user does not have access to this section.'
            );
        }
    
        return $user;
    }
}
