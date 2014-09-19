<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Doctrine\Common\Persistence\ObjectManager;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Dime\TimetrackerBundle\Entity\Amount;

class LoadAmounts extends AbstractFixture implements OrderedFixtureInterface
{

	/**
	 * data for multiple amounts to be loaded (adding up to data of base amount)
	 *
	 * @var array
	 */
	protected $data = array(
		'requirements-initial-amount' => array(
			'service'       => 'requirements',
			'description'   => 'cwe: initial requirements meeting with customer',
			'rateReference' => 'service',
			'chargeable'    => true,
			'value'         => '5',
		),
		'requirements-documentation-amount' => array(
			'service'       => 'requirements',
			'description'   => 'cwe: requirements documentation',
			'rateReference' => 'service',
			'chargeable'    => true,
			'value'         => '6',
		),
		'environment-setup-amount' => array(
			'service'       => 'infrastructure',
			'description'   => 'cwe: vhost setup, PHP configuration, .vimrc, tags',
			'rateReference' => 'service',
			'chargeable'    => true,
			'value'         => '7',
		),
		'project-setup-amount' => array(
			'service'       => 'development',
			'description'   => 'cwe: initial project setup (Symfony2, bundles etc.)',
			'rateReference' => 'service',
			'chargeable'    => true,
			'value'         => '8',
		),
	);

	/**
	 * loads fixtures to database
	 *
	 * @param  Doctrine\Common\Persistence\ObjectManager $manager
	 * @return LoadAmounts
	 */
	public function load(ObjectManager $manager)
	{
		$baseAmount = new Amount();
		$baseAmount->setUser($manager->merge($this->getReference('default-user')))
			->setCustomer($manager->merge($this->getReference('default-customer')))
			->setProject($manager->merge($this->getReference('default-project')))
		;

		foreach ($this->data as $key => $data) {
			$amount = clone $baseAmount;
			$amount->setService($manager->merge($this->getReference($data['service'])))
				->setDescription($data['description'])
				->setRateReference($data['rateReference'])
				->setChargeable($data['chargeable'])
				->setValue($data['value'])
			;

			$manager->persist($amount);
			$this->addReference($key, $amount);
		}

		$manager->flush();

	}

	/**
	 * the order in which fixtures will be loaded (compared to other fixture classes)
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 60;
	}
}
