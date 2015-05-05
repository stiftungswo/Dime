<?php

namespace Dime\TimetrackerBundle\Controller;

use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use FOS\RestBundle\View\View;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class CustomersController extends DimeController
{
    private $handlerSerivce = 'dime.customer.handler';
    
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
     *
     * @Annotations\View(
     * serializerEnableMaxDepthChecks=true
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
	    return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
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
     * serializerEnableMaxDepthChecks=true
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
        return $this->getOr404($id, $this->handlerSerivce);
    }

	/**
	 * Presents the form to use to create a new Entity.
	 *
	 * @ApiDoc(
     * input="Dime\TimetrackerBundle\Form\Type\CustomerFormType",
     * output = "Dime\TimetrackerBundle\Entity\Customer",
     * section="customers",
     * description="A Frontend Function for Post for Languages which suck, Which acts on Parameters Defined in Settings",
	 * resource = true,
	 * statusCodes = {
	 * 200 = "Returned when successful"
	 * }
	 * )
	 *
	 * @Annotations\Route(requirements={"_format"="html"})
	 * @Annotations\QueryParam(name="tags", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="user", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="activity", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="name", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="company", nullable=true, description="Sets the Company Param in the Form.")
     * @Annotations\QueryParam(name="fullname", nullable=true, description="Sets the Fullname Param in the Form.")
     * @Annotations\QueryParam(name="department", nullable=true, description="Sets the Department Param in the Form.")
     * @Annotations\QueryParam(name="salutation", nullable=true, description="Sets the Salutation Param in the Form.")
	 * @Annotations\QueryParam(name="phones", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="alias", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="rateGroup", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="chargeable", nullable=true, description="Sets the Value Param in the Form.")
	 * @Annotations\QueryParam(name="address", nullable=true, description="Sets the Value Param in the Form.")
	 *
	 * @Annotations\View(
	 * serializerEnableMaxDepthChecks=true
	 * )
	 *
	 * @param ParamFetcherInterface $paramFetcher
	 *
	 * @return FormTypeInterface
	 */
    public function newCustomerAction(ParamFetcherInterface $paramFetcher)
    {
        $parameters = $paramFetcher->all();
        $settingsParameters['classname'] = 'customer';
        return $this->get($this->handlerSerivce)->newEntity($parameters, $settingsParameters);
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
            $newCustomer = $this->container->get($this->handlerSerivce)->post($request->request->all());
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
            $entity = $this->getOr404($id, $this->handlerSerivce);
            $entity = $this->container->get($this->handlerSerivce)->put($entity, $request->request->all());
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
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }

	/**
	 * Duplicate Entity
	 *
	 * @ApiDoc(
	 *  resource= true,
	 *  section="customers",
	 *  output = "Dime\TimetrackerBundle\Entity\Customer",
	 *  statusCodes={
	 *      200 = "Returned when successful",
	 *      404 = "Returned when entity does not exist"
	 *  }
	 * )
	 *
	 *
	 * @Annotations\Route(requirements={"_format"="json|xml"})
	 *
	 * @Annotations\View(
	 * serializerEnableMaxDepthChecks=true
	 * )
	 *
	 * @param $id
	 *
	 * @return \Dime\TimetrackerBundle\Model\DimeEntityInterface
	 */
	public function duplicateCustomerAction($id)
	{
		return $this->get($this->handlerSerivce)->duplicate($this->getOr404($id, $this->handlerSerivce));
	}
}