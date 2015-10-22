<?php
namespace Dime\TimetrackerBundle\Decoder;

use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Tag;
use Dime\TimetrackerBundle\Entity\Timeslice;

class ActivityDecoder
{

    /**
     * Decode and create an array output
     *
     * @param string $data
     * @return array
     */
    protected function parse($data)
    {
        $result = array();
        $parsers = array(
            '\Dime\TimetrackerBundle\Parser\TimerangeParser',
            '\Dime\TimetrackerBundle\Parser\DurationParser',
            '\Dime\TimetrackerBundle\Parser\ActivityRelationParser',
            '\Dime\TimetrackerBundle\Parser\ActivityDescriptionParser'
        );
        
        foreach ($parsers as $parser) {
            $p = new $parser();
            $result = $p->setResult($result)->run($data);
            $data = $p->clean($data);
            unset($p);
        }
        
        return $result;
    }

    /*
     * ToDo: Reimplement Command Syntax Handling.
     */
    public function handle($commandstring)
    {
        // create new activity entity
        $activity = new Activity();
        
        // Run parser
        $result = $this->parse($data['parse']);
        if (isset($data['date'])) {
            $date = new \DateTime($data['date']);
        } else {
            $date = new \DateTime();
        }
        
        // create new activity and timeslice entity
        $activity = new Activity();
        $activity->setUser($this->getCurrentUser());
        
        if (isset($result['customer'])) {
            try {
                $customer = $this->getCustomerRepository()
                    ->createCurrentQueryBuilder('c')
                    ->scopeByField('user', $this->getCurrentUser()
                    ->getId())
                    ->scopeByField('alias', $result['customer'])
                    ->getCurrentQueryBuilder()
                    ->setMaxResults(1)
                    ->getQuery()
                    ->getSingleResult();
                
                $activity->setCustomer($customer);
            } catch (NoResultException $e) {
            }
        }
        
        if (isset($result['project'])) {
            try {
                $project = $this->getProjectRepository()
                    ->createCurrentQueryBuilder('p')
                    ->scopeByField('user', $this->getCurrentUser()
                    ->getId())
                    ->scopeByField('alias', $result['project'])
                    ->getCurrentQueryBuilder()
                    ->setMaxResults(1)
                    ->getQuery()
                    ->getSingleResult();
                $activity->setProject($project);
                // Auto set customer because of direct relation to project
                if ($activity->getCustomer() == null) {
                    $activity->setCustomer($project->getCustomer());
                }
            } catch (NoResultException $e) {
            }
        }
        
        if (isset($result['service'])) {
            try {
                $service = $this->getServiceRepository()
                    ->createCurrentQueryBuilder('p')
                    ->scopeByField('user', $this->getCurrentUser()
                    ->getId())
                    ->scopeByField('alias', $result['service'])
                    ->getCurrentQueryBuilder()
                    ->setMaxResults(1)
                    ->getQuery()
                    ->getSingleResult();
                $activity->setService($service);
            } catch (NoResultException $e) {
            }
        }
        
        if (isset($result['tags']) && ! empty($result['tags'])) {
            foreach ($result['tags'] as $tagname) {
                try {
                    $tag = $this->getTagRepository()
                        ->createCurrentQueryBuilder('t')
                        ->scopeByField('user', $this->getCurrentUser()
                        ->getId())
                        ->scopeByField('name', $tagname)
                        ->getCurrentQueryBuilder()
                        ->setMaxResults(1)
                        ->getQuery()
                        ->getSingleResult();
                } catch (NoResultException $e) {
                    $tag = null;
                }
                
                if ($tag == null) {
                    $tag = new Tag();
                    $tag->setName($tagname);
                    $tag->setUser($this->getCurrentUser());
                }
                $activity->addTag($tag);
            }
        }
        
        if (isset($result['description'])) {
            $activity->setDescription($result['description']);
        }
        
        // create timeslice
        $timeslice = new Timeslice();
        $timeslice->setActivity($activity);
        $timeslice->setUser($this->getCurrentUser());
        $activity->addTimeslice($timeslice);
        if (isset($result['range']) || isset($result['value'])) {
            // process time range
            if (isset($result['range'])) {
                $range = $result['range'];
                
                if (empty($range['stop'])) {
                    $start = new \DateTime($range['start']);
                    $stop = new \DateTime('now');
                } elseif (empty($range['start'])) {
                    $start = new \DateTime('now');
                    $stop = new \DateTime($range['stop']);
                } elseif (! empty($range['start']) && ! empty($range['stop'])) {
                    $start = new \DateTime($range['start']);
                    $stop = new \DateTime($range['stop']);
                }
                $start->setDate($date->format('Y'), $date->format('m'), $date->format('d'));
                $stop->setDate($date->format('Y'), $date->format('m'), $date->format('d'));
                
                $timeslice->setStartedAt($start);
                $timeslice->setStoppedAt($stop);
            } else {
                // track date for value
                $date->setTime(0, 0, 0);
                $timeslice->setStartedAt($date);
                $timeslice->setStoppedAt($date);
            }
            
            // process value
            if (isset($result['value'])) {
                if (empty($result['value']['sign'])) {
                    $timeslice->setDuration($result['value']['number']);
                } else {
                    if ($result['value']['sign'] == '-') {
                        $timeslice->setDuration($timeslice->getCurrentDuration() - $result['value']['number']);
                    } else {
                        $timeslice->setDuration($timeslice->getCurrentDuration() + $result['value']['number']);
                    }
                }
            }
        } else {
            // start a new timeslice with date 'now'
            $timeslice->setStartedAt(new \DateTime('now'));
        }
        
        // save change to database
        $em = $this->getDoctrine()->getManager();
        $em->persist($activity);
        $em->flush();
        $em->refresh($activity);
        
        $view = $this->createView($activity);
        
        return $view;
    }
}
