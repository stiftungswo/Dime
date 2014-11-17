<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Rate;
use Dime\TimetrackerBundle\Model\RateUnitType;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadRates extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		//example data
		$rate1 = new Rate();
		$rate1->setRateUnit("CHF/h");
		$rate1->setRateUnitType(RateUnitType::$Hourly);
		$rate1->setRateValue(120);
		$rate1->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate1->setService($this->getReference('consulting_service')); 
		$rate1->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate1);
		$this->addReference('consulting_default_rate', $rate1);

        $rate11 = new Rate();
        $rate11->setRateUnit("CHF/h");
		$rate11->setRateUnitType(RateUnitType::$Hourly);
        $rate11->setRateValue(80);
        $rate11->setRateGroup($this->getReference('canton_rate_group'));
        //TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
        $rate11->setService($this->getReference('consulting_service'));
        $rate11->setUser($manager->merge($this->getReference('default-user')));
        $manager->persist($rate11);
        $this->addReference('consulting_canton_rate', $rate11);
		
		$rate2 = new Rate();
		$rate2->setRateUnit("CHF/h");
		$rate2->setRateUnitType(RateUnitType::$Hourly);
		$rate2->setRateValue(120);
		$rate2->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate2->setService($this->getReference('requirements_service'));
		$rate2->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate2);
		$this->addReference('employee2_rate', $rate2);
		
		$rate3 = new Rate();
		$rate3->setRateUnit("CHF/h");
		$rate3->setRateUnitType(RateUnitType::$Hourly);
		$rate3->setRateValue(120);
		$rate3->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate3->setService($this->getReference('development_service'));
		$rate3->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate3);
		$this->addReference('employee3_rate', $rate3);
		
		$rate4 = new Rate();
		$rate4->setRateUnit("CHF/h");
		$rate4->setRateUnitType(RateUnitType::$Hourly);
		$rate4->setRateValue(120);
		$rate4->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate4->setService($this->getReference('testing_service'));
		$rate4->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate4);
		$this->addReference('employee4_rate', $rate4);
		
		$rate5 = new Rate();
		$rate5->setRateUnit("CHF/h");
		$rate5->setRateUnitType(RateUnitType::$Hourly);
		$rate5->setRateValue(120);
		$rate5->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate5->setService($this->getReference('documentation_service'));
		$rate5->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate5);
		$this->addReference('employee5_rate', $rate5);
		
		$rate6 = new Rate();
		$rate6->setRateUnit("CHF/h");
		$rate6->setRateUnitType(RateUnitType::$Hourly);
		$rate6->setRateValue(120);
		$rate6->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate6->setService($this->getReference('projectManagement_service'));
		$rate6->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate6);
		$this->addReference('employee6_rate', $rate6);
		
		$rate7 = new Rate();
		$rate7->setRateUnit("CHF/h");
		$rate7->setRateUnitType(RateUnitType::$Hourly);
		$rate7->setRateValue(120);
		$rate7->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate7->setService($this->getReference('qualityAssurance_service'));
		$rate7->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate7);
		$this->addReference('employee7_rate', $rate7);
		
		$rate8 = new Rate();
		$rate8->setRateUnit("CHF/h");
		$rate8->setRateUnitType(RateUnitType::$Hourly);
		$rate8->setRateValue(120);
		$rate8->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate8->setService($this->getReference('systemAnalysis_service'));
		$rate8->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate8);
		$this->addReference('employee8_rate', $rate8);		

		$rate9 = new Rate();
		$rate9->setRateUnit("CHF/h");
		$rate9->setRateUnitType(RateUnitType::$Hourly);
		$rate9->setRateValue(120);
		$rate9->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate9->setService($this->getReference('support_service'));
		$rate9->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate9);
		$this->addReference('employee9_rate', $rate9);
		
		$rate10 = new Rate();
		$rate10->setRateUnit("CHF/h");
		$rate10->setRateUnitType(RateUnitType::$Hourly);
		$rate10->setRateValue(120);
		$rate10->setRateGroup($this->getReference('default_rate_group'));
		//TODO urfr resolve the casting problem of service in the following line of code ->getId() ist workarround which works
		$rate10->setService($this->getReference('infrastructure_service'));
		$rate10->setUser($manager->merge($this->getReference('default-user')));
		$manager->persist($rate10);
		$this->addReference('employee10_rate', $rate10);
		
		$manager->flush();
	}

	/**
	 * the order in which fixtures will be loaded
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 25;
	}
}

