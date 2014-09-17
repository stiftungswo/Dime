<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Model\HandlerInterface;
use Dime\TimetrackerBundle\Handler\AbstractHandler;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;

class ProjectHandler extends AbstractHandler implements HandlerInterface
{
    private $formType = 'dime_timetrackerbundle_projectformtype';
    /**
     * @var array allowed filter keys
     */
    protected $allowed_filter = array(
        'customer',
        'withTags',
        'withoutTags',
        'search',
        'user'
    );
    
    public function all($limit = 5, $offset = 0, $filter = array())
    {
        $this->repository->createCurrentQueryBuilder('p');
    
        // Filter
        if ($filter) {
            $this->repository->filter($this->cleanFilter($filter, $this->allowed_filter));
        }
        
        // Scope by current user
        if (!isset($filter['user'])) {
            $this->repository->scopeByField('user', $this->getCurrentUser()->getId());
        }
    
        $this->repository->getCurrentQueryBuilder()->addOrderBy('p.name', 'ASC');
    
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
        return $this->deleteEntity($entity);
    }
}