<?php

namespace Dime\TimetrackerBundle\Controller;

use Dime\ReportBundle\Handler\ReportHandler;
use Dime\TimetrackerBundle\Entity\Customer;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Handler\CustomerHandler;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Swo\CommonsBundle\Controller\DimeController;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class CustomersController extends DimeController
{
    private $handlerService = 'dime.customer.handler';

    private $formType = 'dime_timetrackerbundle_customerformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * description="Gets a Collection of Customers",
     * output = "Dime\TimetrackerBundle\Entity\Customer",
     * section="customers",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="name", requirements="\d+", nullable=true, description="Filter By Name")
     * @Annotations\QueryParam(name="alias", requirements="\d+", nullable=true, description="Filter By Alias")
     * @Annotations\QueryParam(name="fullname", requirements="\d+", nullable=true, description="Filter By Fullname")
     * @Annotations\QueryParam(name="salutation", requirements="\d+", nullable=true, description="Filter By Salutation")
     * @Annotations\QueryParam(name="company", requirements="\d+", nullable=true, description="Filter By Company")
     * @Annotations\QueryParam(name="department", requirements="\d+", nullable=true, description="Filter By Department")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(name="systemCustomer", nullable=true, description="Filter By systemCustomer")
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

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Customer for a given id",
     * output = "Dime\TimetrackerBundle\Entity\Customer",
     * section="customers",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List", "Default"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param int $id
     *            the page id
     *
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getCustomerAction($id)
    {
        return $this->getOr404($id, $this->handlerService);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\TimetrackerBundle\Form\Type\CustomerFormType",
     * output = "Dime\TimetrackerBundle\Entity\Customer",
     * section="customers",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @param Request $request
     *            the request object
     *
     * @return FormTypeInterface|View
     */
    public function postCustomerAction(Request $request)
    {
        try {
            $newCustomer = $this->container->get($this->handlerService)->post($request->request->all());
            return $this->view($newCustomer, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\TimetrackerBundle\Form\Type\CustomerFormType",
     * output = "Dime\TimetrackerBundle\Entity\Customer",
     * section="customers",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Customer does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @param Request $request
     *            the request object
     * @param int $id
     *            the page id
     *
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     *
     */
    public function putCustomerAction(Request $request, $id)
    {
        try {
            $entity = $this->getOr404($id, $this->handlerService);
            $entity = $this->container->get($this->handlerService)->put($entity, $request->request->all());
            return $this->view($entity, Codes::HTTP_OK);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Delete existing Entity
     *
     * @ApiDoc(
     * resource = true,
     * section="customers",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Customer does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @param int $id
     *            the page id
     *
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteCustomerAction($id)
    {
        $this->container->get($this->handlerService)->delete($this->getOr404($id, $this->handlerService));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }

    /**
     * Export filtered entities as csv.
     *
     * @ApiDoc(
     * resource = true,
     * description="Export filtered entities as csv.",
     * section="customers",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="withTags", nullable=true, description="Filter By Tag")
     * @Annotations\QueryParam(name="search", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(name="systemCustomer", nullable=true, description="Filter By systemCustomer")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher customer
     *
     * @return Response
     */
    public function getCustomersExportCsvAction(ParamFetcherInterface $paramFetcher)
    {
        /** @var CustomerHandler $handler */
        $handler = $this->container->get($this->handlerService);

        $result = $handler->getFilteredCustomers($paramFetcher->all());

        $rows = ["sep=,"];

        $esc = function ($str) {
            return ReportHandler::escapeCSV($str, true);
        };

        $row = [
            $esc('Beschreibung'),
            $esc('Firma'),
            $esc('Abteilung'),
            $esc('Anrede'),
            $esc('E-Mail'),
            $esc('Telefonnummer'),
            $esc('Mobiltelefonnummer'),
            $esc('Kommentar'),
            $esc('Ansprechperson'),
            $esc('Verrechenbar'),
            $esc('Systemkunde'),
            $esc('Strasse'),
            $esc('Adresszusatz'),
            $esc('Postleitzahl'),
            $esc('Stadt'),
            $esc('Land'),
            ];
        $rows[] = implode(',', $row);

        /** @var Customer $customer */
        foreach ($result as $customer) {
            $row = [
                $esc($customer->getName()),
                $esc($customer->getCompany() ?? ''),
                $esc($customer->getDepartment() ?? ''),
                $esc($customer->getSalutation() ?? ''),
                $esc($customer->getEmail() ?? ''),
                $esc($customer->getPhone() ?? ''),
                $esc($customer->getMobilephone() ?? ''),
                $esc($customer->getComment() ?? ''),
                $esc($customer->getFullname() ?? ''),
                $esc($customer->isChargeable() ? 1 : 0),
                $esc($customer->isSystemCustomer() ? 1 : 0),
                $esc($customer->getAddress()->getStreet() ?? ''),
                $esc($customer->getAddress()->getSupplement() ?? ''),
                $esc($customer->getAddress()->getPlz() ?? ''),
                $esc($customer->getAddress()->getCity() ?? ''),
                $esc($customer->getAddress()->getCountry() ?? ''),
            ];
            $rows[] = implode(',', $row);
        }


        $csv = implode("\n", $rows);

        $response = new Response($csv);
        $response->headers->set('Content-Type', 'text/csv');
        $response->headers->set(
            'Content-Disposition',
            $response->headers->makeDisposition(ResponseHeaderBag::DISPOSITION_ATTACHMENT, 'kunden.csv')
        );

        return $response;
    }


    /**
     * Check for duplicate customers in db and import.
     *
     * @ApiDoc(
     * resource = true,
     * description="Check for duplicate customers in db and import.",
     * section="customers",
     * statusCodes = {
     * 204 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"}, path="/customers/import/check")
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\RequestParam(name="customers", array=true, description="The customers data to check")
     *
     * @param ParamFetcherInterface $params
     *
     * @return View
     *
     */
    public function postCustomersImportCheckAction(ParamFetcherInterface $params)
    {
        $customers = $params->get("customers");

        /** @var CustomerHandler $customerHandler */
        $customerHandler = $this->container->get($this->handlerService);

        $foundDuplicates = [];
        foreach ($customers as $customer) {
            $foundDuplicates[] = $customerHandler->checkForDuplicateCustomer($customer);
        }

        return $this->view($foundDuplicates, Codes::HTTP_OK);
    }

    /**
     * Import all Customers.
     *
     * @ApiDoc(
     * resource = true,
     * description="Import all Customers.",
     * section="customers",
     * statusCodes = {
     * 201 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"}, path="/customers/import")
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\RequestParam(name="customers", array=true, description="The new customers to import")
     *
     * @param ParamFetcherInterface $params
     *
     * @return View
     *
     */
    public function postCustomersImportAction(ParamFetcherInterface $params)
    {
        $customers = $params->get("customers");

        $customerHandler = $this->container->get($this->handlerService);

        $createdCustomers = [];
        foreach ($customers as $customer) {
            $createdCustomers[] = $customerHandler->post($customer);
        }

        return $this->view($createdCustomers, Codes::HTTP_CREATED);
    }
}
