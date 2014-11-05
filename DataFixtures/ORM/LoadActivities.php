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
		'requirements_initial_activity'       => array(
			'service'     => 'requirements_service',
			'description' => 'cwe: initial requirements meeting with customer',
			'rate'        => 50.0,
		),
		'requirements_documentation_activity' => array(
			'service'     => 'requirements_service',
			'description' => 'cwe: requirements documentation',
			'rate'        => 50.0,
		),
		'environment_setup_activity'          => array(
			'service'     => 'infrastructure_service',
			'description' => 'cwe: vhost setup, PHP configuration, .vimrc, tags',
			'rate'        => 50.0,
		),
		'project_setup_activity'              => array(
			'service'     => 'development_service',
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
			->setProject($manager->merge($this->getReference('default-project')))
			->setChargeableReference(ActivityReference::$SERVICE);

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
