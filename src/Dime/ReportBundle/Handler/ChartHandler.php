<?php
/**
 * Author: Till Wegmüller
 * Date: 3/4/15
 * Dime
 */

namespace Dime\ReportBundle\Handler;

use Dime\TimetrackerBundle\Handler\AbstractHandler;
use Dime\TimetrackerBundle\Model\RateUnitType;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\DependencyInjection\Container;

class ChartHandler extends AbstractHandler
{

    public function __construct(ObjectManager $objectManager, Container $container)
    {
        $this->om = $objectManager;
        $this->formFactory = $container->get('form.factory');
        $this->secContext = $container->get('security.context');
        $this->container = $container;
    }

    public function getServiceTimeByUser($user)
    {
        $timeslicerepo = $this->om->getRepository('DimeTimetrackerBundle:Timeslice');
        $timeslicerepo->createCurrentQueryBuilder('t');
        $qb = $timeslicerepo->getCurrentQueryBuilder();
        $qb->select('COUNT(t.value) AS x')
            ->addSelect('SUM(t.value) AS y')
            ->join('t.activity', 'a')
            ->join('a.service', 's')
            ->join('s.rates', 'r')
            ->where($qb->expr()->eq('t.user', ':user'))
            ->andWhere($qb->expr()->neq('r.rateUnitType', ':rateUnitType'))
            ->groupBy('s.name')
            ->setParameter(':user', $user)
            ->setParameter(':rateUnitType', RateUnitType::$NoChange);
        return $qb->getQuery()->getResult();
    }

    public function getServiceCountByUser($user)
    {
        $timeslicerepo = $this->om->getRepository('DimeTimetrackerBundle:Timeslice');
        $timeslicerepo->createCurrentQueryBuilder('t');
        $qb = $timeslicerepo->getCurrentQueryBuilder();
        $qb->select('s.name AS Service')
            ->addSelect('COUNT(t.value) AS Amount')
            ->join('t.activity', 'a')
            ->join('a.service', 's')
            ->where($qb->expr()->eq('t.user', ':user'))
            ->groupBy('s.name')
            ->setParameter(':user', $user);
        return $qb->getQuery()->getResult();
    }

    public function getProjectTimeByUser($user)
    {
        $timeslicerepo = $this->om->getRepository('DimeTimetrackerBundle:Timeslice');
        $timeslicerepo->createCurrentQueryBuilder('t');
        $qb = $timeslicerepo->getCurrentQueryBuilder();
        $qb->select('p.name AS Projekt')
            ->addSelect('SUM(t.value) AS Stunden')
            ->join('t.activity', 'a')
            ->join('a.project', 'p')
            ->join('a.service', 's')
            ->join('s.rates', 'r')
            ->where($qb->expr()->eq('t.user', ':user'))
            ->andWhere($qb->expr()->neq('r.rateUnitType', ':rateUnitType'))
            ->groupBy('a.project')
            ->setParameter(':user', $user)
            ->setParameter(':rateUnitType', RateUnitType::$NoChange);
        return $qb->getQuery()->getResult();
    }

    public function getServiceTimeByUserAndProject($user, $project)
    {
        $timeslicerepo = $this->om->getRepository('DimeTimetrackerBundle:Timeslice');
        $timeslicerepo->createCurrentQueryBuilder('t');
        $qb = $timeslicerepo->getCurrentQueryBuilder();
        $qb->select('s.name AS Service')
            ->addSelect('SUM(t.value) AS Stunden')
            ->join('t.activity', 'a')
            ->join('a.service', 's')
            ->join('s.rates', 'r')
            ->where($qb->expr()->eq('t.user', ':user'))
            ->andWhere($qb->expr()->eq('a.project', ':project'))
            ->andWhere($qb->expr()->neq('r.rateUnitType', ':rateUnitType'))
            ->groupBy('a.service')
            ->setParameter(':user', $user)
            ->setParameter(':project', $project)
            ->setParameter(':rateUnitType', RateUnitType::$NoChange);
        return $qb->getQuery()->getResult();
    }
}
