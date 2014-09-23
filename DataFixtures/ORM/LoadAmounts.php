<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Amount;
use Dime\TimetrackerBundle\Model\ActivityReference;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadAmounts extends AbstractFixture implements OrderedFixtureInterface
{

	/**
	 * data for multiple amounts to be loaded (adding up to data of base amount)
	 *
	 * @var array
	 */
	protected $data = array(
		'requirements-initial-amount'       => array(
			'service'     => 'requirements',
			'description' => 'cwe: initial requirements meeting with customer',
			'value'       => '5',
		),
		'requirements-documentation-amount' => array(
			'service'     => 'requirements',
			'description' => 'cwe: requirements documentation',
			'value'       => '6',
		),
		'environment-setup-amount'          => array(
			'service'     => 'infrastructure',
			'description' => 'cwe: vhost setup, PHP configuration, .vimrc, tags',
			'value'       => '7',
		),
		'project-setup-amount'              => array(
			'service'     => 'development',
			'description' => 'cwe: initial project setup (Symfony2, bundles etc.)',
			'value'       => '8',
		),
	);

	/**
	 * loads fixtures to database
	 *
	 * @param  Doctrine\Common\Persistence\ObjectManager $manager
	 *
	 * @return LoadAmounts
	 */
	public function load(ObjectManager $manager)
	{
		$baseAmount = new Amount();
		$baseAmount->setUser($manager->merge($this->getReference('default-user')))
			->setCustomer($manager->merge($this->getReference('default-customer')))
			->setProject($manager->merge($this->getReference('default-project')))
			->setChargeable(true)
			->setChargeableReference(ActivityReference::$SERVICE)
			->setRateReference(ActivityReference::$SERVICE);

		foreach($this->data as $key => $data) {
			$amount = clone $baseAmount;
			$amount->setService($manager->merge($this->getReference($data['service'])))
				->setDescription($data['description'])
				->setValue($data['value']);

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
