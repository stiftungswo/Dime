<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\RateGroup;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadRateGroups extends AbstractFixture implements OrderedFixtureInterface
{
	protected $data = array(
		'default_rate_group' => array(
			'name' => 'Default',
			'description' => 'Each service has a rate of the default rate group i.e. this one.',
		),
		'canton_rate_group' => array(
			'name' => 'Canton',
			'description' => 'Rate group for cantons.',
		),
		'comune_rate_group' => array(
			'name' => 'Comune',
			'description' => 'Rate group for comunes.',
		),
		'comune_embrach_rate_group' => array(
			'name' => 'Embrach',
			'description' => 'Rate group for Embrach.',
		),
	);
	protected $baseData = array(
		'user' => 'ref:default-user',
	);
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		$baseEntity = new RateGroup();
		foreach($this->baseData as $key=>$value)
		{
			$this->set($baseEntity, $key, $value, $manager);
		}

		foreach($this->data as $key => $data) {
			$entity = clone $baseEntity;
			foreach($data as $name => $value)
			{
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
					$param = preg_replace('/^const:/', '', $val);
					$entity->$functionName(constant($param));
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
				$param = preg_replace('/^const:/', '', $value);
				$entity->$functionName(constant($param));
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
		return 15;
	}
}

