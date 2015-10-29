<?php
namespace Dime\OfferBundle\Handler;

use Dime\OfferBundle\Entity\Offer;
use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Project;
use Dime\TimetrackerBundle\Handler\GenericHandler;
use Dime\TimetrackerBundle\Entity\RateUnitType;

class OfferHandler extends GenericHandler
{
	/**
	 * Creates a Project from an Offer
	 *
	 * @param Offer $offer
	 *
	 * @return \Dime\TimetrackerBundle\Entity\Project
	 */
    public function createProjectFromOffer(Offer $offer)
    {
	    $project = $offer->getProject();
	    if($project !== null){
		    return $project;
	    }

        $project = new Project();
        $project->setCustomer($offer->getCustomer());
        $project->setName($offer->getName());
        $project->setChargeable(true);
        $project->setRateGroup($offer->getRateGroup());
        $project->setBudgetPrice($offer->getSubtotal());
        $project->setDescription($offer->getShortDescription());
        $budgetTime = 0;
        foreach($offer->getOfferPositions() as $offerPosition){

            //calculate budget
            $budgetTime += $offerPosition->getAmountInHours();

            //create activities
            $activity = new Activity();
            $activity->setProject($project);
            $activity->setService($offerPosition->getService());
            $activity->setRateValue($offerPosition->getRateValue());
            $activity->setRateUnit($offerPosition->getRateUnit());
            $activity->setRateUnitType($offerPosition->getRateUnitType());
            $activity->setChargeable($offerPosition->isChargeable());
	        $activity->setVat($offerPosition->getVat());
	        $project->addActivity($activity);
        }
        $project->setBudgetTime($budgetTime);
        $project->setFixedPrice($offer->getFixedPrice());
        $this->om->persist($project);

	    $offer->setProject($project);
        $project->setUser($this->getCurrentUser());

	    $this->om->persist($offer);
	    $this->om->flush();
	    return $project;
    }

}