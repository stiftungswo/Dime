<?php
namespace Dime\TimetrackerBundle\Handler;

use Dime\TimetrackerBundle\Event\DimeEntityPersistEvent;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\TimetrackEvents;
use Doctrine\Common\Persistence\ObjectManager;
use FOS\UserBundle\Model\UserInterface;
use FOS\UserBundle\Model\UserManager;
use Symfony\Component\DependencyInjection\Container;

class PeriodHandler extends GenericHandler
{
    /**
     * Get a list of all taken holiday between start and end date.
     *
     * @param $date start and end date
     * @param $employeeId id of employeee
     *
     * @return array
     */
    public function allTakenHolidays($date, $employeeId)
    {
        return  $this->repository->findAllTakenHolidays($date, $employeeId);
    }
}
