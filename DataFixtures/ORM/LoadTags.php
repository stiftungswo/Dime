<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Tag;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadTags extends AbstractFixture implements OrderedFixtureInterface
{

	/**
	 * data for multiple activities to be loaded (adding up to data of base activity)
	 *
	 * @var array
	 */
	protected $data = array(
		'tag-invoiced' => array(
			'name' => 'invoiced'
		),
	);

	protected $baseData = array(
		'system' => false,
	);

	/**
	 * loads fixtures to database
	 *
	 * @param ObjectManager $manager
	 *
	 * @return LoadTags
	 */
	public function load(ObjectManager $manager)
	{
		$baseEntity = new Tag();
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
		return 80;
	}
}
