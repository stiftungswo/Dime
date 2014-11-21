<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Timeslice;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadTimeslices extends AbstractFixture implements OrderedFixtureInterface
{

	protected $data = array(
		'time1' => array(
			'duration'  => 7200, // 2 * 3600
			'startedAt' => '2014-11-20 10:00:00',
			'activity'  => 'ref:buero_programming_activity'
		),
		'time2' => array(
			'duration'  => 5400, // 1.5 * 3600
			'startedAt' => '2014-11-21 13:00:00',
			'activity'  => 'ref:buero_infrastructure_activity',
		),
		'time3' => array(
			'duration'  => 9000, // 2.5 * 3600
			'startedAt' => '2014-11-22 08:00:00',
			'activity'  => 'ref:cargo_zivi_activity',
		),
		'time4' => array(
			'duration'  => 30600, // 8.5 * 3600
			'startedAt' => '2014-11-23 08:00:00',
			'activity'  => 'ref:chrutzi_leiter_activity',
		),
		'time5' => array(
			'duration'  => 30600, // 8.5 * 3600
			'startedAt' => '2014-11-23 08:00:00',
			'activity'  => 'ref:chrutzi_zivih_activity',
		),
		'time6' => array(
			'duration'  => 30600, // 8.5 * 3600
			'startedAt' => '2014-11-23 08:00:00',
			'activity'  => 'ref:chrutzi_zivih_activity',
			'user'      => 'ref:test-user'
		),
	);

	protected $baseData = array(
		'user'   => 'ref:default-user',
	);

	/**
	 * loads fixtures to database
	 *
	 * @param  \Doctrine\Common\Persistence\ObjectManager $manager
	 *
	 * @return LoadActivities
	 */
	public function load(ObjectManager $manager)
	{
		$baseEntity = new Timeslice();
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
	 * the order in which fixtures will be loaded (compared to other fixture classes)
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 70;
	}
}
