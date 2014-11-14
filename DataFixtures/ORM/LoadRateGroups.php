<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\RateGroup;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadRateGroups extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		//default must exist
		$default = new RateGroup();
		//TODO urfr find solution for initial value
		$default->setName('Default');
		$default->setDescription('Each service has a rate of the default rate group i.e. this one.');
		$default->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($default);
		$this->addReference('default_rate_group', $default);

		//example data
		$canton = new RateGroup();
		$canton->setName('Canton');
		$canton->setDescription('Rate group for cantons.');
		$canton->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($canton);
		$this->addReference('canton_rate_group', $canton);
		
		$comune = new RateGroup();
		$comune->setName('Comune');
		$comune->setDescription('Rate group for comunes.');
		$comune->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($comune);
		$this->addReference('comune_rate_group', $comune);
		
		$comune_embrach = new RateGroup();
		$comune_embrach->setName('Embrach');
		$comune_embrach->setDescription('Rate group for Embrach.');
		$comune_embrach->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($comune_embrach);
		$this->addReference('comune_embrach_rate_group', $comune_embrach);
		
		$manager->flush();
	}

	/**
	 * the order in which fixtures will be loaded
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 15;
	}
}

