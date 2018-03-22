<?php
/**
 * Author: Till Wegmüller
 * Date: 6/11/15
 * Dime
 */

namespace Dime\ReportBundle\Controller;

use Carbon\Carbon;
use Dime\ReportBundle\Handler\ReportHandler;
use Dime\TimetrackerBundle\Controller\DimeController;
use Doctrine\Common\Collections\ArrayCollection;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\HttpFoundation\Response;

class ReportController extends DimeController
{
    /**
     *
     *
     * @ApiDoc(
     * resource = true,
     * section="report",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="employee", requirements="\d+", nullable=true, description="Filter By Employee")
     * @Annotations\QueryParam(name="date", nullable=true, description="Filter by date use Format YYYY-MM-DD or YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     * @Annotations\QueryParam(name="customer", requirements="\d+", nullable=true, description="Filter By Timeslice")
     * @Annotations\QueryParam(name="service", requirements="\d+", nullable=true, description="Filter By Service")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(
     *              requirements={"_format"="json|xml"}
     * )
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return array
     */
    public function getReportsExpenseAction(ParamFetcherInterface $paramFetcher)
    {
        $reportHandler = $this->container->get('dime.report.handler');

        $report = $reportHandler->getExpenseReport($paramFetcher->all());
        $report->setComments(new ArrayCollection($reportHandler->getExpensesReportComments($paramFetcher->all())));

        return $report;
    }

    /**
     *
     *
     * @ApiDoc(
     * resource = true,
     * section="report",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when entity does not exist"
     * }
     * )
     *
     * @Annotations\QueryParam(name="project", requirements="\d+", nullable=true, description="Filter By Project")
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="employee", requirements="\d+", nullable=true, description="Filter By Employee")
     * @Annotations\QueryParam(name="date", nullable=true, description="Filter by date use Format YYYY-MM-DD or YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     * @Annotations\QueryParam(name="customer", requirements="\d+", nullable=true, description="Filter By Timeslice")
     * @Annotations\QueryParam(name="service", requirements="\d+", nullable=true, description="Filter By Service")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return Response
     */
    public function printReportsExpenseAction(ParamFetcherInterface $paramFetcher)
    {
        // disable notices from PHPPdf which breaks this
        error_reporting(E_ALL & ~E_NOTICE);
        /** @var ReportHandler $reportHandler */
        $reportHandler = $this->container->get('dime.report.handler');

        $reportItems = [];

        $report = $reportHandler->getExpenseReport($paramFetcher->all());

        $comments = $reportHandler->getExpensesReportComments($paramFetcher->all());

        foreach ($report->getGroupedTimeslices() as $date => $timeSlices) {
            $reportItems[$date]['timeslices'] = $timeSlices;
        }

        foreach ($comments as $comment) {
            $group = $comment->getDate()->format('d.m.Y');
            if (isset($reportItems[$group]['comment'])) {
                $reportItems[$group]['comment'] .= "\n" . $comment->getComment();
            } else {
                $reportItems[$group]['comment'] = $comment->getComment();
            }
        }

        uksort($reportItems, function ($date1, $date2) {
            return Carbon::parse($date1) <=> Carbon::parse($date2);
        });

        $header = [
            'Content-Disposition' => sprintf('filename="aufwandsrapport_%s.pdf"', $report->getId()),
        ];

        return $this->get('dime.print.pdf')->render(
            'DimeReportBundle:Reports:ExpenseReport.pdf.twig',
            [
                'report' => $report,
                'reportItems' => $reportItems,
            ],
            'DimeReportBundle:Reports:stylesheet.xml.twig',
            $header
        );
    }

    /**
     *
     *
     * @ApiDoc(
     * resource = true,
     * section="report",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="date", nullable=true, description="Filter by date use Format YYYY-MM-DD or YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     *
     *
     * @Annotations\View(
     *  serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(
     * requirements={"_format"="json|xml"}
     * )
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return array
     */
    public function getReportsZiviweeklyAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get('dime.report.handler')->getZiviWeekReport($paramFetcher->all());
    }

    /**
     *
     *
     * @ApiDoc(
     * resource = true,
     * section="report",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="date", nullable=false, description="Filter by date use Format YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     *
     *
     * @Annotations\View(
     *  serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(
     * requirements={"_format"="json|xml"}
     * )
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return array
     */
    public function getReportsServicehoursAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get('dime.report.handler')->getServicehoursReport($paramFetcher->get('date'));
    }

    /**
     *
     *
     * @ApiDoc(
     * resource = true,
     * section="report",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="date", nullable=false, description="Filter by date use Format YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     *
     *
     * @Annotations\View(
     *  serializerEnableMaxDepthChecks=true
     * )
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return array
     */
    public function getReportsServicehoursCsvAction(ParamFetcherInterface $paramFetcher)
    {
        $data = $this->container->get('dime.report.handler')->getServicehoursReportAsCSV($paramFetcher->get('date'));

        $response = new Response($data);
        //$response->headers->set('Content-Type', 'text/html');
        $response->headers->set('Content-Type', 'text/csv');
        $response->headers->set('Content-Disposition', 'attachment; filename="servicerapport.csv"');

        return $response;
    }

    /**
     *
     *
     * @ApiDoc(
     * resource = true,
     * section="report",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="date", nullable=false, description="Filter by date use Format YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     *
     * @Annotations\View(
     *  serializerEnableMaxDepthChecks=true
     * )
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return array
     */
    public function getReportsRevenueCsvAction(ParamFetcherInterface $paramFetcher)
    {
        $data = $this->container->get('dime.report.handler')->getRevenueReportAsCSV($paramFetcher->get('date'));

        $response = new Response($data);
        $response->headers->set('Content-Type', 'text/csv; charset=latin1');
        $response->headers->set('Content-Disposition', 'attachment; filename="umsatzrapport.csv"');

        return $response;
    }

    /**
     *
     *
     * @ApiDoc(
     * resource = true,
     * section="report",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="project", requirements="\d+", nullable=false, description="Project")
     * @Annotations\QueryParam(name="date", nullable=true, description="Filter by date use Format YYYY-MM-DD or YYYY-MM-DD,YYYY-MM-DD to specify daterange")
     *
     *
     * @Annotations\View(
     *  serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\Route(
     * requirements={"_format"="json|xml"}
     * )
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return array
     */
    public function getReportsProjectemployeeAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get('dime.report.handler')->getProjectemployeeReport($paramFetcher->get('project'), $paramFetcher->get('date'));
    }
}
