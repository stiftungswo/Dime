<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Setting;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadSettings extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * @var array
	 * Data to be loaded
	 */
	protected $data = array(
		'new_service_name'       => array(
			'namespace'     => '/etc/defaults/service',
			'name' => 'name',
			'value' => 'New Service',
		),
		'new_timeslice_activity'       => array(
			'namespace'     => '/etc/defaults/timeslice',
			'name' => 'activity',
			'value' => 'action:byName:Zivi*',
		),
		'new_timeslice_value'       => array(
			'namespace'     => '/etc/defaults/timeslice',
			'name' => 'value',
			'value' => '30240',
		),
		'new_timeslice_startedAt'       => array(
			'namespace'     => '/etc/defaults/timeslice',
			'name' => 'startedAt',
			'value' => 'action:nextDate',
		),
		'new_customer_name'       => array(
			'namespace'     => '/etc/defaults/customer',
			'name' => 'name',
			'value' => 'New Customer',
		),
		'new_project_name'       => array(
			'namespace'     => '/etc/defaults/project',
			'name' => 'name',
			'value' => 'New Project',
		),
		'new_rate_rateGroup'       => array(
			'namespace'     => '/etc/defaults/rate',
			'name' => 'rateGroup',
			'value' => 1,
		),
		'new_rategroup_name'       => array(
			'namespace'     => '/etc/defaults/rategroup',
			'name' => 'name',
			'value' => 'New RateGroup',
		),
		'new_tag_name'       => array(
			'namespace'     => '/etc/defaults/tag',
			'name' => 'name',
			'value' => 'New Tag',
		),
	);

	protected $baseData = array(
		'user' => 'ref:default-user'
	);


	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		$baseEntity = new Setting();
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
		return 80;
	}
}

