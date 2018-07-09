<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\TimetrackerBundle\EventListener;

use Doctrine\Common\Annotations\AnnotationReader;
use Doctrine\Common\EventSubscriber;

class DiscriminatorListener implements EventSubscriber
{
    // The driver of Doctrine, can be used to find all loaded classes
    private $driver;
    // The *temporary* map used for one run, when computing everything
    private $map;
    // The cached map, this holds the results after a computation, also for other classes
    private $cachedMap;
    const ENTRY_ANNOTATION = 'Dime\TimetrackerBundle\Annotation\DiscriminatorEntry';
    public function getSubscribedEvents()
    {
        return array( \Doctrine\ORM\Events::loadClassMetadata );
    }
    public function __construct(\Doctrine\ORM\EntityManager $db)
    {
        $this->driver = $db->getConfiguration()->getMetadataDriverImpl();
        $this->cachedMap = array();
    }
    public function loadClassMetadata(\Doctrine\ORM\Event\LoadClassMetadataEventArgs $event)
    {
        // Reset the temporary calculation map and get the classname
        $this->map = array();
        $class = $event->getClassMetadata()->name;
        // Did we already calculate the map for this element?
        if (array_key_exists($class, $this->cachedMap)) {
            $this->overrideMetadata($event, $class);
            return;
        }
        // Do we have to process this class?
        if (count($event->getClassMetadata()->discriminatorMap) == 0
            && $this->extractEntry($class)) {
            // Now build the whole map
            $this->checkFamily($class);
        } else {
            // Nothing to do…
            return;
        }
        // Create the lookup entries
        $dMap = array_flip($this->map);
        foreach ($this->map as $cName => $discr) {
            $this->cachedMap[$cName]['map'] = $dMap;
            $this->cachedMap[$cName]['discr'] = $this->map[$cName];
        }
        // Override the data for this class
        $this->overrideMetadata($event, $class);
    }
    private function overrideMetadata(\Doctrine\ORM\Event\LoadClassMetadataEventArgs $event, $class)
    {
        // Set the discriminator map and value
        $event->getClassMetadata()->discriminatorMap = $this->cachedMap[$class]['map'];
        $event->getClassMetadata()->discriminatorValue = $this->cachedMap[$class]['discr'];
        // If we are the top-most parent, set subclasses!
        if (isset($this->cachedMap[$class]['isParent']) && $this->cachedMap[$class]['isParent'] === true) {
            $subclasses = $this->cachedMap[$class]['map'];
            unset($subclasses[$this->cachedMap[$class]['discr']]);
            $event->getClassMetadata()->subClasses = array_values($subclasses);
        }
    }
    private function checkFamily($class)
    {
        $rc = new \ReflectionClass($class);
        $parent = $rc->getParentClass()->name;
        if ($parent !== false) {
            // Also check all the children of our parent
            $this->checkFamily($parent);
        } else {
            // This is the top-most parent, used in overrideMetadata
            $this->cachedMap[$class]['isParent'] = true;
            // Find all the children of this class
            $this->checkChildren($class);
        }
    }
    private function checkChildren($class)
    {
        foreach ($this->driver->getAllClassNames() as $name) {
            $cRc = new \ReflectionClass($name);
            $cParent = $cRc->getParentClass()->name;
            // Haven't done this class yet? Go for it.
            if (!array_key_exists($name, $this->map) && $cParent == $class && $this->extractEntry($name)) {
                $this->checkChildren($name);
            }
        }
    }

    private function extractEntry($class)
    {
        $reader = new AnnotationReader();
        $class = new \ReflectionClass($class);
        $annotations = $reader->getClassAnnotations($class);
        $success = false;
        if (array_key_exists(self::ENTRY_ANNOTATION, $annotations['class'])) {
            $value = $annotations['class'][self::ENTRY_ANNOTATION]->value;
            if (in_array($value, $this->map)) {
                throw new \Exception("Found duplicate discriminator map entry '" . $value . "' in " . $class);
            }
            $this->map[$class] = $value;
            $success = true;
        }

        return $success;
    }
}
