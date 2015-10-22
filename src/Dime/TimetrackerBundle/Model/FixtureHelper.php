<?php
/**
 * Author: Till Wegmüller
 * Date: 11/20/14
 * Dime
 */

namespace Dime\TimetrackerBundle\Model;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\Persistence\ObjectManager;

class FixtureHelper extends AbstractFixture
{
    public function set($entity, $property, $value, ObjectManager $manager)
    {
        if (is_array($value)) {
            $functionName = 'add' . ucfirst($property);
            foreach ($value as $val) {
                if (preg_match('/^ref:/', $val) === 1) {
                    $this->refSet($entity, $functionName, $val, $manager);
                } elseif (preg_match('/^const:/', $val) === 1) {
                    $this->constSet($entity, $functionName, $val);
                } else {
                    $this->genericSet($entity, $functionName, $val);
                }
            }
        } else {
            $functionName = 'set' . ucfirst($property);
            if (preg_match('/^ref:/', $value) === 1) {
                $this->refSet($entity, $functionName, $value, $manager);
            } elseif (preg_match('/^const:/', $value) === 1) {
                $this->constSet($entity, $functionName, $value);
            } else {
                $this->genericSet($entity, $functionName, $value);
            }
        }
    }

    private function genericSet($entity, $functionName, $param)
    {
        $entity->$functionName($param);
    }

    private function refSet($entity, $functionName, $param, ObjectManager $manager)
    {
        $val = preg_replace('/^ref:/', '', $param);
        $entity->$functionName($manager->merge($this->getReference($val)));
    }

    private function constSet($entity, $functionName, $param)
    {
        $classandval = preg_split('/::/', preg_replace('/^const:/', '', $param));
        $class = new \ReflectionClass($classandval[0]);
        $param = $class->getStaticPropertyValue($classandval[1]);
        $entity->$functionName($param);
    }

    /**
     * Load data fixtures with the passed EntityManager
     *
     * @param \Doctrine\Common\Persistence\ObjectManager $manager
     */
    function load(ObjectManager $manager)
    {
    }
}
