<?php

namespace Dime\EmployeeBundle\Controller;

use Dime\TimetrackerBundle\Controller\DimeController;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use FOS\RestBundle\View\View;
use Symfony\Component\Form\FormTypeInterface;
use Symfony\Component\HttpFoundation\Request;
use FOS\RestBundle\Request\ParamFetcherInterface;
use FOS\RestBundle\Util\Codes;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use FOS\RestBundle\Controller\Annotations;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class EmployeesController extends DimeController
{
    private $handlerSerivce = 'dime.Employee.handler';

    private $formType = 'dime_employeebundle_Employeeformtype';

    /**
     * List all Entities.
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\QueryParam(name="customer", requirements="\d+", nullable=true, description="Filter By Customer")
     * @Annotations\QueryParam(name="user", requirements="\d+", nullable=true, description="Filter By User")
     * @Annotations\QueryParam(name="search", requirements="\w+", nullable=true, description="Filter By Name or alias")
     * @Annotations\QueryParam(array=true, name="withtags", requirements="\d+", nullable=true, description="Show Entities with these Tags")
     * @Annotations\QueryParam(array=true, name="withouttags", requirements="\d+", nullable=true, description="Show Entities without this Tags")
     *
     * @Annotations\View(
     * templateVar="Employees"
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param ParamFetcherInterface $paramFetcher
     *            param fetcher Employee
     *
     * @return array
     */
    public function getEmployeesAction(ParamFetcherInterface $paramFetcher)
    {
        return $this->container->get($this->handlerSerivce)->all($paramFetcher->all());
    }

    /**
     * Get single Entity
     *
     * @ApiDoc(
     * resource = true,
     * description = "Gets a Employee for a given id",
     * output = "Dime\employeebundle\Entity\Employee",
     * statusCodes = {
     * 200 = "Returned when successful",
     * 404 = "Returned when the page is not found"
     * }
     * )
     *
     * @Annotations\View(templateVar="Employee")
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param Request $request
     *            the request object
     * @param int $id
     *            the page id
     *
     * @return array
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function getEmployeeAction($id)
    {
        return $this->getOr404($id, $this->handlerSerivce);
    }

    /**
     * Presents the form to use to create a new Entity.
     *
     * @ApiDoc(
     * resource = true,
     * statusCodes = {
     * 200 = "Returned when successful"
     * }
     * )
     *
     * @Annotations\View(
     * templateVar = "form"
     * )
     *
     * @Annotations\Route(requirements={"_format"="html"})
     * @Annotations\QueryParam(name="tags", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="user", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="name", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="customer", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="alias", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="startedAt", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="stoppedAt", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="deadline", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="description", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="budgetPrice", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="fixedPrice", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="budgetTime", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="rateGroup", nullable=true, description="Sets the Value Param in the Form.")
     * @Annotations\QueryParam(name="chargeable", nullable=true, description="Sets the Value Param in the Form.")
     *
     *
     * @param ParamFetcherInterface $paramFetcher
     *
     * @return FormTypeInterface
     */
    public function newEmployeeAction(ParamFetcherInterface $paramFetcher)
    {
        $parameters = $paramFetcher->all();
        $settingsParameters['classname'] = 'employee';
        return $this->get($this->handlerSerivce)->newEntity($parameters, $settingsParameters);
    }

    /**
     * Create a new Entity from the submitted data.
     *
     * @ApiDoc(
     * resource = true,
     * description = "Creates a new page from the submitted data.",
     * input = "Dime\Employeebundle\Form\Type\EmployeeFormType",
     * statusCodes = {
     * 201 = "Returned when successful",
     * 400 = "Returned when the form has errors"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     *
     * @param Request $request
     *            the request object
     *
     * @return FormTypeInterface|View
     */
    public function postEmployeeAction(Request $request)
    {
        try {
            $newEmployee = $this->container->get($this->handlerSerivce)->post($request->request->all());
            return $this->view($newEmployee, Codes::HTTP_CREATED);
        } catch (InvalidFormException $exception) {
            return $exception->getForm();
        }
    }

    /**
     * Update existing Entity.
     *
     * @ApiDoc(
     * resource = true,
     * input = "Dime\employeebundle\Form\Type\EmployeeFormType",
     * statusCodes = {
     * 200 = "Returned when the Entity was updated",
     * 400 = "Returned when the form has errors",
     * 404 = "Returned when the Employee does not exist"
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
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
    public function putEmployeeAction(Request $request, $id)
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
     * input = "Dime\employeebundle\Form\Type\EmployeeFormType",
     * statusCodes = {
     * 204 = "Returned when successful",
     * 404 = "Returned when Employee does not exist."
     * }
     * )
     *
     * @Annotations\Route(requirements={"_format"="json|xml"})
     * @Annotations\View()
     *
     * @param int $id
     *            the page id
     *
     * @return FormTypeInterface|View
     *
     * @throws NotFoundHttpException when page not exist
     */
    public function deleteEmployeeAction($id)
    {
        $this->container->get($this->handlerSerivce)->delete($this->getOr404($id, $this->handlerSerivce));
        return $this->view(null, Codes::HTTP_NO_CONTENT);
    }
}
