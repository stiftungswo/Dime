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

	/**
	 * loads fixtures to database
	 *
	 * @param ObjectManager $manager
	 *
	 * @return LoadTags
	 */
	public function load(ObjectManager $manager)
	{
		$baseTag = new Tag();
		$baseTag
			->setUser($manager->merge($this->getReference('default-user')));

		foreach($this->data as $key => $data) {
			$tag = clone $baseTag;
			$tag->setName($data['name']);

			$manager->persist($tag);
			$this->addReference($key, $tag);
		}

		$manager->flush();

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
