<?php

namespace Dime\TimetrackerBundle\Tests\Entity;

use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

abstract class DimeRepositoryTestCase extends KernelTestCase
{

    /**
     * @var \Doctrine\ORM\EntityManager
     */
    protected $em;

    /**
     * {@inheritDoc}
     */

    protected const ENTITY_NAME='undefined';
    protected const QB_ALIAS='x';

    // boot up things
    public function setUp()
    {
        self::bootKernel();
        $this->em = static::$kernel->getContainer()->get('doctrine')->getManager();
    }

    // get different variants of a repo
    protected function getRepo($entity_name = null)
    {
        if (is_null($entity_name)) {
            $entity_name = $this::ENTITY_NAME;
        }

        return $this->em->getRepository($entity_name);
    }

    protected function getRepoWithQB($qb_name = null, $entity_name = null)
    {
        if (is_null($qb_name)) {
            $qb_name = $this::QB_ALIAS;
        }

        return $this->getRepo($entity_name)->createCurrentQueryBuilder($qb_name);
    }

    protected function getQBFromRepo($qb_name = null, $entity_name = null)
    {
        return $this->getRepoWithQB($qb_name, $entity_name)->getCurrentQueryBuilder();
    }

    protected function tearDown()
    {
        parent::tearDown();

        $this->em->close();
        $this->em = null; // avoid memory leaks
    }
}
