<?php
namespace Dime\TimetrackerBundle\DataFixtures\ORM;

use Dime\TimetrackerBundle\Entity\Customer;
use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Swo\CommonsBundle\Entity\Address;
use Swo\CommonsBundle\Entity\AddressCity;
use Swo\CommonsBundle\Entity\AddressCountry;
use Swo\CommonsBundle\Entity\AddressState;
use Swo\CommonsBundle\Entity\AddressStreet;

class LoadCustomers extends AbstractFixture implements OrderedFixtureInterface
{
	/**
	 * @var array
	 * Data to be loaded
	 */
	protected $data = array(
		'swo-customer'       => array(
			'name'     => 'StiftungSWO',
			'alias' => 'stiftungswo',
			'address'   => array(
				'streetnumber' => '18b',
				'street' => 'Bahnstrasse',
				'city'  => 'Dübendorf',
				'plz' => 8600,
				'state' => 'Zürich',
				'state_shortcode' => 'ZH',
				'country' => 'Schweiz',
			),
		),
		'duebendorf-customer'       => array(
			'name'     => 'Dübendorf',
			'alias' => 'duebendorf',
			'address'   => array(
				'streetnumber' => '5',
				'street' => 'Hauptstrasse',
				'city'  => 'Dübendorf',
				'plz' => 8600,
				'state' => 'Zürich',
				'state_shortcode' => 'ZH',
				'country' => 'Schweiz',
			),
		),
	);

	protected $baseData = array(
		'user'  => 'ref:default-user',
		'chargeable' => true,
	);
	/**
	 * Load data fixtures with the passed EntityManager
	 *
	 * @param \Doctrine\Common\Persistence\ObjectManager $manager
	 */
	public function load(ObjectManager $manager)
	{
		$baseEntity = new Customer();
		foreach($this->baseData as $key=>$value)
		{
			$this->set($baseEntity, $key, $value, $manager);
		}

		foreach($this->data as $key => $data) {
			$entity = clone $baseEntity;
			foreach($data as $name => $value)
			{
				if($name === 'address') {
					$addressdata    = $value;
					$address        = new Address();
					$address
						->setStreet($addressdata['street'])
						->setCity($addressdata['city'])
						->setPlz($addressdata['plz'])
						->setState($addressdata['state'])
						//->setShortcode($addressdata['state_shortcode'])
						->setCountry($addressdata['country'])
						->setStreetnumber($addressdata['streetnumber']);
					$entity->setAddress($address);
				} else {
					$this->set($entity, $name, $value, $manager);
				}
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
	 * the order in which fixtures will be loaded
	 *
	 * @return int
	 */
	public function getOrder()
	{
		return 30;
	}
}

