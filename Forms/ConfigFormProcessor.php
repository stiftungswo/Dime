<?php
namespace Dime\InvoiceBundle\Forms;
use Symfony\Component\HttpFoundation\Request;
use Dime\InvoiceBundle\TimeTrackerServiceClient\TimeTrackerServiceClient;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Form\Form;

/**
*
* processes the Config Form
* helper class for the config action of the Invoice Controller
* @author jeti
*
*/
class ConfigFormProcessor extends FormProcessor
{
  protected $invoice_customer;

  /**
   *
   * initialization
   * @param int $invoice_customer
   * @param Form $form
   * @param Request $request
   * @param Controller $controller
   */
  public function  __construct($invoice_customer, Form $form, Request $request, Controller $controller)
  {
    $this->invoice_customer = $invoice_customer;
    parent::__construct($form, $request, $controller);
  }
  
  /**
   *
   * submits the form data
   */
  public function submitConfigForm()
  {
    $this->form->bindRequest($this->request);
    if ($this->form->isValid()) {
      $data=$this->form->getData();
      $address=$data['address'];
      $this->invoice_customer->setAddress($address);
      $em = $this->controller->getDoctrine()->getEntityManager();
      $em->persist($this->invoice_customer);
      $em->flush();
    }
    return $this->controller->redirect($this->controller->generateUrl('DimeInvoiceBundle_customers'));
  }
}