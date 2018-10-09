<?php

namespace Swo\CustomerBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;

class CustomerController extends DimeController
{

    private $handlerService = 'swo.customer.handler';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * description="Gets a Collection of customers",
     * output = "Swo\CustomerBundle\Entity\Customer",
     * section="customers",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="hideForBusiness", nullable=true, description="Filter By hideForBusiness")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher customer
     *
     * @return array
     */
    public function getCustomersAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerService)->all($paramFetcher->all());
    }
}
