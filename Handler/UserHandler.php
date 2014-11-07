<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Model\HandlerInterface;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use FOS\UserBundle\Model\UserInterface;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\Form\FormFactoryInterface;
use Symfony\Component\Security\Core\SecurityContext;
use FOS\UserBundle\Model\UserManager;

class UserHandler extends GenericHandler
{
    private $userManager;

     /* (non-PHPdoc)
      * @see \Dime\TimetrackerBundle\Handler\AbstractHandler::__construct()
      */
     public function __construct(ObjectManager $om, $entityClass, FormFactoryInterface $formFactory, SecurityContext $secContext, UserManager $userManager, $alias, $formType)
     {
        parent::__construct($om, $entityClass, $formFactory, $secContext, $alias, $formType);
        $this->userManager = $userManager;
     }

	/**
	 * (non-PHPdoc)
	 * @see      \Dime\TimetrackerBundle\Model\HandlerInterface::all()
	 *
	 * @param array $params
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
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::post()
     */
    public function post(array $parameters)
    {
        $entity = $this->userManager->createUser();
        return $this->processForm($entity, $parameters, $this->formType,'POST');
    }

    /**
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::put()
     */
    public function put(DimeEntityInterface $entity, array $parameters)
    {
        return $this->processForm($entity, $parameters, $this->formType, 'PUT');
    }
    
    /**
     * Enables the User
     * @param UserInterface $user
     */
    public function enable(UserInterface $user)
    {
        $user->setEnabled(true);
        $this->om->persist($user);
        $this->om->flush();
    }
    
    /**
     * Locks the User
     * @param UserInterface $user
     */
    public function lock(UserInterface $user)
    {
        $user->setEnabled(false);
        $this->om->persist($user);
        $this->om->flush();
    }
    
    /*
     * A Slightly Changed Function to Properly handle User Entities
     */
    protected function processForm(DimeEntityInterface $entity, array $parameters, $form, $method = "PUT", $formoptions = array())
    {
        $formoptions['method'] = $method;
        $form = $this->formFactory->create($form, $entity, $formoptions);
        $form->submit($parameters, 'PUT' !== $method);
        if ($form->isValid()) {
            $user = $form->getData();
            $this->userManager->updatePassword($user);
            $this->userManager->updateUser($user);
            return $user;
        }
        throw new InvalidFormException('Invalid submitted data', $form);
    }
}