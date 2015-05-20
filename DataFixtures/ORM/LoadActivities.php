<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Activity;
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
		'buero_programming_activity'       => array(
			'project'   => 'ref:default-project',
			'service'     => 'ref:zivih_service',
			'description' => 'DimERP Programmieren',
		),
		'buero_infrastructure_activity' => array(
			'project'   => 'ref:default-project',
			'service'     => 'ref:zivih_service',
			'description' => 'Arbeiten an der Infrastrucktur',
		),
		'cargo_zivi_activity'          => array(
			'project'   => 'ref:default-project',
			'service'     => 'ref:zivih_service',
			'description' => 'Arbeiten im Cargo',
		),
		'chrutzi_leiter_activity'              => array(
			'project'   => 'ref:third-project',
			'service'     => 'ref:leiterh_service',
			'description' => 'Einsatzleiterstunden im Chrutzelriet',
		),
		'chrutzi_zivih_activity'              => array(
			'project'   => 'ref:third-project',
			'service'     => 'ref:zivih_service',
			'description' => 'Zivistunden im Chrutzelriet',
		),
		'chrutzi_entsorgung_activity'              => array(
			'project'   => 'ref:third-project',
			'service'     => 'ref:entsorgung_service',
			'description' => 'Grüngutentsorgung im Chrutzelriet',
		),
		'chrutzi_transport1_activity'              => array(
			'project'   => 'ref:third-project',
			'service'     => 'ref:transport1_service',
			'description' => 'Transport Personen zum Chrutzelriet',
		),
		'chrutzi_transport2_activity'              => array(
			'project'   => 'ref:third-project',
			'service'     => 'ref:transport2_service',
			'description' => 'Transport Material zum Chrutzelriet',
		),
	);

	protected $baseData = array(
		'user' => 'ref:default-user',
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
		$baseEntity = new Activity();
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
				} else {
					$entity->$functionName($val);
				}
			}
		} else {
			$functionName = 'set' . ucfirst($property);
			if(preg_match('/^ref:/', $value) === 1) {
				$param = preg_replace('/^ref:/', '', $value);
				$entity->$functionName($manager->merge($this->getReference($param)));
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
		return 60;
	}
}
