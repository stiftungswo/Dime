<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Model\ActivityReference;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadActivities extends AbstractFixture implements OrderedFixtureInterface
{

	/**
	 * data for multiple activities to be loaded (adding up to data of base activity)
	 *
	 * @var array
	 */
	protected $data = array(
		'requirements-initial'       => array(
			'service'     => 'requirements',
			'description' => 'cwe: initial requirements meeting with customer',
			'rate'        => 50.0,
		),
		'requirements-documentation' => array(
			'service'     => 'requirements',
			'description' => 'cwe: requirements documentation',
			'rate'        => 50.0,
		),
		'environment-setup'          => array(
			'service'     => 'infrastructure',
			'description' => 'cwe: vhost setup, PHP configuration, .vimrc, tags',
			'rate'        => 50.0,
		),
		'project-setup'              => array(
			'service'     => 'development',
			'description' => 'cwe: initial project setup (Symfony2, bundles etc.)',
			'rate'        => 50.0,
		),
	);

	/**
	 * loads fixtures to database
	 *
	 * @param  Doctrine\Common\Persistence\ObjectManager $manager
	 *
	 * @return LoadActivities
	 */
	public function load(ObjectManager $manager)
	{
		$baseActivity = new Activity();
		$baseActivity->setUser($manager->merge($this->getReference('default-user')))
			->setCustomer($manager->merge($this->getReference('default-customer')))
			->setProject($manager->merge($this->getReference('default-project')))
			->setChargeable(true)
			->setChargeableReference(ActivityReference::$SERVICE)
			->setRateReference(ActivityReference::$SERVICE);

		foreach($this->data as $key => $data) {
			$activity = clone $baseActivity;
			$activity->setService($manager->merge($this->getReference($data['service'])))
				->setDescription($data['description'])
				->setRate($data['rate']);

			$manager->persist($activity);
			$this->addReference($key, $activity);
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
