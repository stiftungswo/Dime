<?php

namespace Swo\CustomerBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Swo\CustomerBundle\Handler\CompanyHandler;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class CompanyController extends DimeController
{
    private $handlerService = 'swo.company.handler';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * description="Gets a Collection of Companies",
     * output = "Swo\CustomerBundle\Entity\Company",
     * section="companies",
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="name", requirements="\w+", nullable=true, description="Filter By Name")
     * @Annotations\QueryParam(name="alias", requirements="\w+", nullable=true, description="Filter By Alias")
     * @Annotations\QueryParam(name="department", requirements="\w+", nullable=true, description="Filter By Department")
     * @Annotations\QueryParam(name="hideForBusiness", nullable=true, description="Filter By hideForBusiness")
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true,
     * serializerGroups={"List"}
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher company
     *
     * @return array
     */
    public function getCompaniesAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerService)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a company for a given id",
     * output = "Swo\CustomerBundle\Entity\Company",
     * section="companies",
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
     * @return DimeEntityInterface
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getCompanyAction($id)
    {
        return $this->getOr404($id, $this->handlerService);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Swo\CustomerBundle\Form\Type\CompanyFormType",
     * output = "Swo\CustomerBundle\Entity\Company",
     * section="companies",
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
    public function postCompanyAction(Request $request)
    {
        try {
            $newCompany = $this->container->get($this->handlerService)->post($request->request->all());
            return $this->view($newCompany, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Swo\CustomerBundle\Form\Type\CompanyFormType",
     * output = "Swo\CustomerBundle\Entity\Company",
     * section="companies",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Company does not exist"
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
    public function putCompanyAction(Request $request, $id)
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
     * section="companies",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Company does not exist."
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
    public function deleteCompanyAction($id)
    {
        $this->container->get($this->handlerService)->delete($this->getOr404($id, $this->handlerService));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }

    /**
     * Check for duplicate companies in db and import.
     *
     * @ApiDoc(
     * resource = true,
     * description="Check for duplicate companies in db and import.",
     * section="companies",
     * statusCodes = {
     * 204 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"}, path="/companies/import/check")
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\RequestParam(name="companies", array=true, description="The company data to check")
     *
     * @param ParamFetcherInterface $params
     *
     * @return View
     *
     */

    public function postCompaniesImportCheckAction(ParamFetcherInterface $params)
    {
        $companies = $params->get("companies");
        /** @var CompanyHandler $companyHandler */
        $companyHandler = $this->container->get($this->handlerService);
        $foundDuplicates = [];
        foreach ($companies as $company) {
            $foundDuplicates[] = $companyHandler->checkForDuplicateCompany($company);
        }
        return $this->view($foundDuplicates, Codes::HTTP_OK);
    }

    /**
     * Import all companies.
     *
     * @ApiDoc(
     * resource = true,
     * description="Import all Companies.",
     * section="companies",
     * statusCodes = {
     * 201 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"}, path="/companies/import")
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
     * )
     *
     * @Annotations\RequestParam(name="companies", array=true, description="The new companies to import")
     *
     * @param ParamFetcherInterface $params
     *
     * @return View
     *
     */

    public function postCompaniesImportAction(ParamFetcherInterface $params)
    {
        $companies = $params->get("companies");
        $companyHandler = $this->container->get($this->handlerService);
        $addressHandler = $this->container->get('swo.address.handler');
        $phoneHandler = $this->container->get('swo.phone.handler');
        $createdCompanies = [];

        foreach ($companies as $company) {
            // take out phones and addresses
            $phones = $company['phoneNumbers'];
            unset($company['phoneNumbers']);
            $addresses = $company['addresses'];
            unset($company['addresses']);

            // create new company
            $newCompany = $companyHandler->post($company);
            
            // create new phones and addresses
            foreach ($addresses as $address) {
                $address['customer'] = $newCompany->getId();
                $addressHandler->post($address);
            }

            // create new phones and addresses
            foreach ($phones as $phone) {
                $phone['customer'] = $newCompany->getId();
                $phoneHandler->post($phone);
            }

            $createdCompanies[] = $newCompany;
        }
        return $this->view($createdCompanies, Codes::HTTP_CREATED);
    }
}
