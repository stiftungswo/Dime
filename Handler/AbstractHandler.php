<?php
namespace Dime\TimetrackerBundle\Handler;

use Doctrine\Common\Persistence\ObjectManager;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
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

    public function __construct(ObjectManager $om, $entityClass, Container $container, $alias, $formType)
    {
        $this->om = $om;
        $this->entityClass = $entityClass;
        $this->repository = $this->om->getRepository($this->entityClass);
        $this->formFactory = $container->get('form.factory');
        $this->secContext = $container->get('security.context');
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
            $this->om->persist($entity);
            $this->om->flush($entity);
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
	protected function createForm(DimeEntityInterface $entity, $formtype, array $values, $formoptions = array()){
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
        $this->om->remove($entity);
        $this->om->flush();
    }

    /**
     * Clean up filter array
     *
     * @param array $filter
     *
     * @return array $result
     */
    protected function cleanFilter(array $filter)
    {
        $result = array();
        foreach($filter as $key=>$value)
        {
	        if (!empty($value))
	        {
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
		foreach($params as $param)
		{
			if (!empty($param))
			{
				return true;
			}
		}
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
                'This user does not have access to this section.');
        }
    
        return $user;
    }
}