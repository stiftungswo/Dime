<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Rate;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Money\Money;

class LoadRates extends AbstractFixture implements OrderedFixtureInterface
{
	protected $data = array(
		'zivih_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 10000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:zivih_service',
		),
		'zivih_canton_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 8000,
			'rateGroup' => 'ref:canton_rate_group',
			'service' => 'ref:zivih_service',
		),
		'leiterh_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 16000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:leiterh_service',
		),
		'entsorgung_default_rate' => array(
			'rateUnit' => 'Kg',
			'rateValue' => 3000,
			'rateUnitType' => 'const:\Dime\TimetrackerBundle\Model\RateUnitType::NoChange',
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:entsorgung_service',
		),
		'transport1_default_rate' => array(
			'rateUnit' => 'KM',
			'rateUnitType' => 'const:\Dime\TimetrackerBundle\Model\RateUnitType::NoChange',
			'rateValue' => 6500,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:transport1_service',
		),
		'transport2_default_rate' => array(
			'rateUnit' => 'KM',
			'rateValue' => 5000,
			'rateUnitType' => 'const:\Dime\TimetrackerBundle\Model\RateUnitType::NoChange',
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:transport2_service',
		),
		'motorsense_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 4000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:motorsense_service',
		),
		'handwerkzeug_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 3000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:handwerkzeug_service',
		),
		'motorsaege_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 9000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:motorsaege_service',
		),
		'motormaeher_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 11000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:motormaeher_service',
		),
		'dumper_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 20000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:dumper_service',
		),
		'habegger_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 20000,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:habegger_service',
		),
		'entbuschungszange_default_rate' => array(
			'rateUnit' => 'CHF/h',
			'rateValue' => 7500,
			'rateGroup' => 'ref:default_rate_group',
			'service' => 'ref:entbuschungszange_service',
		),
	);
	protected $baseData = array(
		'user' => 'ref:default-user',
		'rateUnitType' => 'const:\Dime\TimetrackerBundle\Model\RateUnitType::Hourly',
	);
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		$baseEntity = new Rate();
		foreach($this->baseData as $key=>$value)
		{
			$this->set($baseEntity, $key, $value, $manager);
		}

		foreach($this->data as $key => $data) {
			$entity = clone $baseEntity;
			foreach($data as $name => $value)
			{
				if($name==='rateValue'){
					$value = Money::CHF($value);
				}
				$this->set($entity, $name, $value, $manager);
			}

			$manager->persist($entity);
			$this->addReference($key, $entity);
		}

		$manager->flush();
	}

	private function set($entity, $property, $value, ObjectManager $manager)
	{
		if(is_array($value)){
			$functionName = 'add' . ucfirst($property);
			foreach($value as $val)
			{
				if(preg_match('/^ref:/', $val) === 1) {
					$param = preg_replace('/^ref:/', '', $val);
					$entity->$functionName($manager->merge($this->getReference($param)));
				} elseif (preg_match('/^const:/', $val) === 1){
					$classandval = preg_split('/::/', preg_replace('/^const:/', '', $value));
					$class = new \ReflectionClass($classandval[0]);
					$param = $class->getStaticPropertyValue($classandval[1]);
					$entity->$functionName($param);
				} else {
					$entity->$functionName($val);
				}
			}
		} else {
			$functionName = 'set' . ucfirst($property);
			if(preg_match('/^ref:/', $value) === 1) {
				$param = preg_replace('/^ref:/', '', $value);
				$entity->$functionName($manager->merge($this->getReference($param)));
			} elseif (preg_match('/^const:/', $value) === 1){
				$classandval = preg_split('/::/', preg_replace('/^const:/', '', $value));
				$class = new \ReflectionClass($classandval[0]);
				$param = $class->getStaticPropertyValue($classandval[1]);
				$entity->$functionName($param);
			} else {
				$entity->$functionName($value);
			}
		}
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

