<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Entity\RateUnitType;
use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\TimetrackEvents;
use Doctrine\Common\Persistence\ObjectManager;
use FOS\UserBundle\Model\UserInterface;
use FOS\UserBundle\Model\UserManager;
use Symfony\Component\DependencyInjection\Container;
use Carbon\Carbon;

class ProjectHandler extends GenericHandler
{
    /**
     * Get a list of all projects which still have open invoices.
     *
     * @return array
     */
    public function allProjectsWithOpenInvoices()
    {
        $projects = $this->repository->findAll();
        // TODO: only return the once with open invoices
        return $projects;
    }
}
