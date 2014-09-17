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

class UserHandler extends AbstractHandler implements HandlerInterface
{
    private $formType = 'dime_timetrackerbundle_userformtype';
    
    private $userManager;

     /* (non-PHPdoc)
      * @see \Dime\TimetrackerBundle\Handler\AbstractHandler::__construct()
      */
     public function __construct(ObjectManager $om, $entityClass, FormFactoryInterface $formFactory, SecurityContext $secContext, UserManager $userManager) 
     {
        parent::__construct($om, $entityClass, $formFactory, $secContext);
        $this->userManager = $userManager;
     }

    /**
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::all()
     */
    public function all($limit = 5, $offset = 0)
    {
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

    /**
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::post()
     */
    public function post(array $parameters)
    {
        $entity = $this->userManager->createUser();
        return $this->processUser($entity, $parameters, $this->formType,'POST');
    }

    /**
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::put()
     */
    public function put(DimeEntityInterface $entity, array $parameters)
    {
        return $this->processUser($entity, $parameters, $this->formType, 'PUT');
    }
    
    /*
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::delete()
     */
    public function delete(DimeEntityInterface $entity)
    {
        return $this->deleteEntity($entity);
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
    private function processUser(DimeEntityInterface $entity, array $parameters, $form, $method = "PUT", $formoptions = array())
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