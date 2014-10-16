<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Service;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadServices extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		$consulting = new Service();
		$consulting->setName('Consulting');
		$consulting->setAlias('consulting');
		$consulting->setChargeable(true);
		$consulting->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($consulting);
		$this->addReference('consulting_service', $consulting);

		$requirements = new Service();
		$requirements->setName('Requirements');
		$requirements->setAlias('requirements');
		$requirements->setChargeable(true);
		$requirements->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($requirements);
		$this->addReference('requirements_service', $requirements);

		$development = new Service();
		$development->setName('Development');
		$development->setAlias('development');
		$development->setChargeable(true);
		$development->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($development);
		$this->addReference('development_service', $development);

		$testing = new Service();
		$testing->setName('Testing');
		$testing->setAlias('testing');
		$testing->setChargeable(true);
		$testing->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($testing);
		$this->addReference('testing_service', $testing);

		$documentation = new Service();
		$documentation->setName('Documentation');
		$documentation->setAlias('documentation');
		$documentation->setChargeable(true);
		$documentation->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($documentation);
		$this->addReference('documentation_service', $documentation);

		$projectManagement = new Service();
		$projectManagement->setName('Project management');
		$projectManagement->setAlias('project-management');
		$projectManagement->setChargeable(true);
		$projectManagement->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($projectManagement);
		$this->addReference('projectManagement_service', $projectManagement);

		$qualityAssurance = new Service();
		$qualityAssurance->setName('Quality assurance');
		$qualityAssurance->setAlias('quality-assurance');
		$qualityAssurance->setChargeable(true);
		$qualityAssurance->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($qualityAssurance);
		$this->addReference('qualityAssurance_service', $qualityAssurance);

		$systemAnalysis = new Service();
		$systemAnalysis->setName('System analysis');
		$systemAnalysis->setAlias('system-analysis');
		$systemAnalysis->setChargeable(true);
		$systemAnalysis->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($systemAnalysis);
		$this->addReference('systemAnalysis_service', $systemAnalysis);

		$support = new Service();
		$support->setName('Support');
		$support->setAlias('support');
		$support->setChargeable(true);
		$support->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($support);
		$this->addReference('support_service', $support);

		$infrastructure = new Service();
		$infrastructure->setName('Infrastructure');
		$infrastructure->setAlias('infrastructure');
		$infrastructure->setChargeable(true);
		$infrastructure->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($infrastructure);
		$this->addReference('infrastructure_service', $infrastructure);

		$manager->flush();
	}

	/**
	 * the order in which fixtures will be loaded
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 20;
	}
}

