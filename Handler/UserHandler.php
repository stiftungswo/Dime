<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Model\HandlerInterface;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;

class UserHandler extends AbstractHandler implements HandlerInterface
{
    public function all($limit = 5, $offset = 0)
    {
        return $this->repository->findBy(array(), null, $limit, $offset);
    }

    public function patch(DimeEntityInterface $entity,array $parameters)
    {
        return $this->processForm($entity, $parameters, 'PATCH', 'user');
    }

    public function post(array $parameters)
    {
        $user = $this->newClassInstance();
        return $this->processForm($user, $parameters, 'POST', 'user');
    }

    public function get($id)
    {
        return $this->repository->find($id);
    }

    public function put(DimeEntityInterface $entity, array $parameters)
    {
        return $this->processForm($entity, $parameters, 'PUT', 'user');
    }
    

    
}