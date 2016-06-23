<?php
namespace Dime\TimetrackerBundle\Handler;

use Money\Money;
use Symfony\Component\DependencyInjection\Container;

class ProjectHandler extends GenericHandler
{
    /**
     * Get a list of all projects which still have open invoices.
     *
     * @return array
     */
    public function allProjectsWithOpenInvoices()
    {
        $projects = $this->repository->findAll();
        $projectsWithOpenInvoices = array();
        foreach ($projects as $project) {
            if ($project->isChargeable()) {
                $projectPrice = $project->calculateCurrentPrice();
                if ($projectPrice != null) {
                    if ($projectPrice->getAmount() > 0) {
                        $clearedAmount = Money::CHF(0);
                        if (!$project->getInvoices()->isEmpty()) {
                            foreach ($project->getInvoices() as $invoice) {
                                $clearedAmount = $clearedAmount->add($invoice->getSubTotal());
                            }
                        }
                        if ($projectPrice->greaterThan($clearedAmount)) {
                            array_push($projectsWithOpenInvoices, $project);
                        }
                    }
                }
            }
        }
        return $projectsWithOpenInvoices;
    }
}
