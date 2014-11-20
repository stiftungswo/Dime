<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\StandardDiscount;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadStandardDiscounts extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{	

		$discount1 = new StandardDiscount();
        $discount1->setName('Skonto 2%');
        $discount1->setMinus(true);
        $discount1->setPercentage(true);
        $discount1->setValue(0.02);
        $discount1->setUser($manager->merge($this->getReference('default-user')));
		$this->addReference('skonto_standarddiscount', $discount1);
		$manager->persist($discount1);

        $discount2 = new StandardDiscount();
        $discount2->setName('Flat Rate 10CHF');
        $discount2->setMinus(true);
        $discount2->setPercentage(false);
        $discount2->setValue(50);
        $discount2->setUser($manager->merge($this->getReference('default-user')));
        $this->addReference('flatrate_standarddiscount', $discount2);
        $manager->persist($discount2);

		$manager->flush();
	}

	/**
	 * the order in which fixtures will be loaded
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 90;
	}
}

