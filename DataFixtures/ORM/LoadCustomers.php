<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Customer;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Swo\CommonsBundle\Entity\Address;
use Swo\CommonsBundle\Entity\AddressCity;
use Swo\CommonsBundle\Entity\AddressCountry;
use Swo\CommonsBundle\Entity\AddressState;
use Swo\CommonsBundle\Entity\AddressStreet;

class LoadCustomers extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		$customer1 = new Customer();
		$customer1->setName('CWE Customer');
		$customer1->setAlias('cc');
		$customer1->setChargeable(true);
		$customer1->setUser($manager->merge($this->getReference('default-user')));
		$address = new Address();
		$address->setStreetnumber('18b');
		$addressStreet = new AddressStreet();
		$addressStreet->setName('BlubStrasse');
		$address->setStreet($addressStreet);
		$addressCity = new AddressCity();
		$addressCity->setName('Zürich');
		$addressCity->setPlz(8000);
		$address->setCity($addressCity);
		$addressState = new AddressState();
		$addressState->setName('Zürich');
		$addressState->setShortcode('ZH');
		$address->setState($addressState);
		$addressCountry = new AddressCountry();
		$addressCountry->setName('Schweiz');
		$address->setCountry($addressCountry);
		$customer1->setAddress($address);

		$manager->persist($customer1);

		$customer2 = new Customer();
		$customer2->setName('Another Customer');
		$customer2->setAlias('ac');
		$customer2->setChargeable(true);
		$customer2->setUser($manager->merge($this->getReference('default-user')));

		$manager->persist($customer2);
		$manager->flush();

		$this->addReference('default-customer', $customer1);
		$this->addReference('another-customer', $customer2);
	}

	/**
	 * the order in which fixtures will be loaded
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 30;
	}
}

