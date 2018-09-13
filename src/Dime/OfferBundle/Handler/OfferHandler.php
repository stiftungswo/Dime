<?php
namespace Dime\OfferBundle\Handler;

use Dime\OfferBundle\Entity\Offer;
use Dime\TimetrackerBundle\Entity\Activity;
use Dime\TimetrackerBundle\Entity\Project;
use Swo\CommonsBundle\Handler\GenericHandler;
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
        if ($project !== null) {
            return $project;
        }

        $project = new Project();
        $project->setCustomer($offer->getCustomer());
        $project->setName($offer->getName());
        $project->setChargeable(true);
        if ($offer->getRateGroup() !== null) {
            $project->setRateGroup($offer->getRateGroup());
        } elseif ($offer->getCustomer() !== null) {
            $project->setRateGroup($offer->getCustomer()->getRateGroup());
        }
        $project->setDescription($offer->getShortDescription());
        if ($offer->getFixedPrice() != null && $offer->getFixedPrice()->isZero()) {
            $project->setBudgetPrice($offer->getSubtotal());
        } else {
            $project->setBudgetPrice($offer->getFixedPrice());
            $project->setFixedPrice($offer->getFixedPrice());
        }
        $budgetTime = 0;
        foreach ($offer->getOfferPositions() as $offerPosition) {
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
        $project->setAccountant($offer->getAccountant());
        $this->om->persist($project);

        $offer->setProject($project);
        $project->setUser($this->getCurrentUser());

        $this->om->persist($offer);
        $this->om->flush();
        return $project;
    }
}
