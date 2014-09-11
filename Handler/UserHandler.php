<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Model\HandlerInterface;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use FOS\UserBundle\Model\UserInterface;

class UserHandler extends AbstractHandler implements HandlerInterface
{

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
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::patch()
     */
    public function patch(DimeEntityInterface $entity, array $parameters)
    {
        return $this->processForm($entity, $parameters, 'dime_timetrackerbundle_userformtype', 'PATCH');
    }

    /**
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::post()
     */
    public function post(array $parameters)
    {
        $user = $this->newClassInstance();
        return $this->processForm($user, $parameters, 'dime_timetrackerbundle_userformtype','POST');
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
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::put()
     */
    public function put(DimeEntityInterface $entity, array $parameters)
    {
        return $this->processForm($entity, $parameters, 'dime_timetrackerbundle_userformtype', 'PUT');
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
}