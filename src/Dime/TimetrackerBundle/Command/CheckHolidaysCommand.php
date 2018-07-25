<?php

namespace Dime\TimetrackerBundle\Command;

use Carbon\Carbon;
use Dime\EmployeeBundle\Entity\Holiday;
use Doctrine\ORM\EntityManager;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Class CheckHolidaysCommand
 *
 * checks if there are enough holidays left in the Database
 * @see https://github.com/stiftungswo/Dime/issues/109
 * @package Dime\TimetrackerBundle\Command
 */
class CheckHolidaysCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('dime:check-holidays')
            ->setDescription('Check if there are still enough holiday entries left');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $container = $this->getContainer();
        /** @var EntityManager $em */
        $em = $container->get('doctrine.orm.entity_manager');

        $holidayRepository = $em->getRepository(Holiday::class)->createCurrentQueryBuilder('h');
        $queryBuilder = $holidayRepository->getCurrentQueryBuilder()->addOrderBy('h.date', 'DESC')->setMaxResults(1);
        /** @var Holiday $result */
        $result = $queryBuilder->getQuery()->getResult()[0];

        $minDate = Carbon::now()->addMonth()->addWeeks(3);

        if ($result->getDate() > $minDate) {
            return; // all good
        }

        $output->writeln("Es sind nicht mehr genügend Feiertage im Dime eingetragen!");
        $output->writeln("Es müssen immer für mindestens das nächste Jahr Feiertage hinterlegt sein.");
    }
}
