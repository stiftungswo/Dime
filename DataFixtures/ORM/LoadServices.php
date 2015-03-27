<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Service;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class LoadServices extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * @var array
	 * Data to be loaded
	 */
	protected $data = array(
		'zivih_service'       => array(
			'name'     => 'Zivistunden',
			'alias' => 'zivistunden',
			'vat'   => 0.08,
		),
		'leiterh_service'       => array(
			'name'     => 'Einsatzleiterstunden',
			'alias' => 'einsatzleiterstuden',
			'vat'   => 0.08,
		),
		'entsorgung_service'       => array(
			'name'     => 'Grüngutentsorgung',
			'alias' => 'grüngutentsorgung',
			'vat'   => 0.08,
		),
		'transport1_service'       => array(
			'name'     => 'Transport Personen',
			'alias' => 'transport-personen',
			'vat'   => 0.08,
		),
		'transport2_service'       => array(
			'name'     => 'Transport Material',
			'alias' => 'transport-material',
			'vat'   => 0.08,
		),
		'motorsense_service'       => array(
			'name'     => 'Motorsense',
			'alias' => 'motorsense',
			'vat'   => 0.08,
		),
		'handwerkzeug_service'       => array(
			'name'     => 'Handwerkzeug',
			'alias' => 'handwerkzeug',
			'vat'   => 0.08,
		),
		'motorsaege_service'       => array(
			'name'     => 'Motorsäge',
			'alias' => 'motorsaege',
			'vat'   => 0.08,
		),
		'motormaeher_service'       => array(
			'name'     => 'Motormäher',
			'alias' => 'motormaeher',
			'vat'   => 0.08,
		),
		'dumper_service'       => array(
			'name'     => 'Dumper',
			'alias' => 'dumper',
			'vat'   => 0.08,
		),
		'habegger_service'       => array(
			'name'     => 'Habegger',
			'alias' => 'habegger',
			'vat'   => 0.08,
		),
		'entbuschungszange_service'       => array(
			'name'     => 'Entbuschungszange',
			'alias' => 'entbuschungszange',
			'vat'   => 0.08,
		),
	);

	protected $baseData = array(
		'user' => 'ref:default-user',
		'chargeable' => true,
	);

	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		$baseEntity = new Service();
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
		return 20;
	}
}

