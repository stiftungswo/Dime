<?php
namespace Dime\TimetrackerBundle\Handler;

use Doctrine\Common\Persistence\ObjectManager;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Symfony\Component\Form\FormFactoryInterface;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Security\Core\SecurityContext;

abstract class AbstractHandler
{

    protected $om;

    protected $entityClass;

    protected $repository;

    protected $formFactory;
    
    protected $secContext;

	protected $alias;

	protected $formType;

    public function __construct(ObjectManager $om, $entityClass, FormFactoryInterface $formFactory, SecurityContext $secContext, $alias, $formType)
    {
        $this->om = $om;
        $this->entityClass = $entityClass;
        $this->repository = $this->om->getRepository($this->entityClass);
        $this->formFactory = $formFactory;
        $this->secContext = $secContext;
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
	 * @param array  $parameters
	 * @param String $method
	 *
	 *
	 * @return \Dime\TimetrackerBundle\Model\DimeEntityInterface|mixed
	 * @throws \Dime\TimetrackerBundle\Exception\InvalidFormException
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