<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Model\HandlerInterface;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Symfony\Component\DependencyInjection\ContainerAwareInterface;
use Doctrine\Common\Proxy\Exception\InvalidArgumentException;

class TimesliceHandler extends AbstractHandler implements HandlerInterface
{
    protected $userhandler;
    /**
     * @var array allowed filter keys
     */
    protected $allowed_filter = array(
        'date',
        'activity',
        'customer',
        'project',
        'service',
        'user',
        'withTags',
        'withoutTags'
    );
    
    public function __construct($om, $entityClass, $formFactory, $userHandler)
    {
        parent::__construct($om, $entityClass, $formFactory);
        $this->userhandler = $userHandler;
    }
    
    /*
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::get()
     */
    public function get($id)
    {
        // TODO: Auto-generated method stub
    }
    
    /*
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::all()
     */
    public function all($limit = 5, $offset = 0, $filter = array())
    {
        $this->repository->createCurrentQueryBuilder('ts');

        // Filter
        if ($filter)  {
            $this->repository->filter($this->cleanFilter($filter, $this->allowed_filter));
        }

        // Scope by current user
        if (!isset($filter['user'])) {
            $this->repository->scopeByUser($this->getCurrentUser()->getId());
        }

        // Sort by updatedAt
        $this->repository->getCurrentQueryBuilder()->addOrderBy('ts.updatedAt', 'DESC');

        // Pagination
        return $this->repository->findBy(array(), null, $limit, $offset);
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
            throw new InvalidArgumentException('User Missing', '500');
        }
        $user = $this->userhandler->get($parameters['user']);
        return $this->processForm($entity, $parameters, 'dime_timetrackerbundle_timesliceformtype', 'POST', array('user' => $user));
    }
    
    /*
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::put()
     */
    public function put(DimeEntityInterface $entity, array $parameters)
    {
        if (!isset($parameters['user']))
        {
            throw new InvalidArgumentException('User Missing', '500');
        }
        $user = $this->userhandler->get($parameters['user']);
        return $this->processForm($entity, $parameters, 'dime_timetrackerbundle_timesliceformtype', 'PUT', array('user' => $user));
    }
    
    /*
     * (non-PHPdoc)
     * @see \Dime\TimetrackerBundle\Model\HandlerInterface::patch()
     */
    public function patch(DimeEntityInterface $entity, array $parameters)
    {
        if (!isset($parameters['user']))
        {
            throw new InvalidArgumentException('User Missing', '500');
        }
        $user = $this->userhandler->get($parameters['user']);
        return $this->processForm($entity, $parameters, 'dime_timetrackerbundle_timesliceformtype', 'PATCH', array('user' => $user));
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