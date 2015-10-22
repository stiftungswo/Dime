<?php

namespace Dime\ReportBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

/**
 * Class ChartController
 * @package Dime\ChartBundle\Controller
 * @Route("/chart")
 */
class ChartController extends DimeController
{
    /**
     * Get the amount of time spent by service for user
     *
     * @param id
     *
     * @return array
     *
     * @ApiDoc(
     * resource = true,
     * section="chart",
     * description="Get the amount of time spent by service for user",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Route("/servicetimebyuser/{id}")
     *
     */
    public function getChartServiceTimeByUser($id)
    {
        return $this->get('dime.chart.handler')->getServiceTimeByUser($id);
    }

    /**
     * Get the number of times a user has made an entry by Service
     *
     * @param id
     *
     * @return array
     *
     * @ApiDoc(
     * resource = true,
     * section="chart",
     * description="Get the number of times a user has made an entry by Service",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Route("/servicecountbyuser/{id}")
     *
     */
    public function getChartServiceCountByUser($id)
    {
        return $this->get('dime.chart.handler')->getServiceCountByUser($id);
    }

    /**
     * Get the amount of time a User has spent in Projects
     *
     * @param id
     *
     * @return array
     *
     * @ApiDoc(
     * resource = true,
     * section="chart",
     * description="Get the amount of time a User has spent in Projects",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Route("/projecttimebyuser/{id}")
     *
     */
    public function getChartProjectTimeByUser($id)
    {
        return $this->get('dime.chart.handler')->getProjectTimeByUser($id);
    }

    /**
     * Get the amount of time a User has spent on a service in Project
     *
     * @param id
     *
     * @param project
     *
     * @return array
     *
     * @ApiDoc(
     * resource = true,
     * section="chart",
     * description="Get the amount of time a User has spent on a service in Project",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Route("/projecttimebyuserandproject/{id}/{project}")
     *
     */
    public function getChartServiceTimeByUserAndProject($id, $project)
    {
        return $this->get('dime.chart.handler')->getServiceTimeByUserAndProject($id, $project);
    }
}
