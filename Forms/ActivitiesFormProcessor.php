<?php

namespace Dime\InvoiceBundle\Forms;
use Symfony\Component\HttpFoundation\Request;
use Dime\InvoiceBundle\TimeTrackerServiceClient\TimeTrackerServiceClient;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Form\Form;

/**
 * 
 * processes the Activities Form
 * helper class for the activities action of the Invoice Controller
 * @author jeti
 *
 */
class ActivitiesFormProcessor extends FormProcessor
{
  protected $customer_id;
  protected $activities;
  
  /**
   *
   * Initialization
   * @param int $customer_id
   * @param array $activities
   * @param Form $form
   * @param Request $request
   * @param Controller $controller
   */
  public function __construct($customer_id, array $activities, Form $form, Request $request, Controller $controller)
  {
    $this->customer_id = $customer_id;
    $this->activities = $activities;
    parent::__construct($form, $request, $controller);
  }

  /**
   *
   * submits the form data
   */
  public function submitActivitiesForm()
  {
    $tscl = new TimeTrackerServiceClient($this->controller);
    $this->form->bindRequest($this->request);
    if ($this->form->isValid()) {
      $items=array();
      $data=$this->form->getData();
      $invoice_number=$data['invoice_number'];
      $sum=0;
      foreach ($this->activities as $activity){
        $charge=$data['charge'.$activity['id']];
        if ($charge){
          $timeslices=$tscl->timeslicesByActivity($activity['id']);
          $duration=0;
          foreach ($timeslices as $timeslice){
            $duration+=$timeslice['duration'];
          }
          $price=($duration*$activity['rate'])/3600;
          $item['description']=$data['description'.$activity['id']];
          $item['duration']=number_format($duration/3600, 2);
          $item['rate']=number_format($activity['rate'], 2);
          $item['price']=number_format($price, 2);
          $items[]=$item;
          $sum+=$price;
          $sum=number_format($sum, 2);
        }
      }
      $vat=$sum*0.19;
      $brutto=$sum+$vat;
      $customer = $tscl->getAPIResult('get_customer',$this->customer_id);
      $invoice_customer=$this->controller->getDoctrine()->getRepository('DimeInvoiceBundle:InvoiceCustomer')->findOneByCoreId($this->customer_id);
      if (!$invoice_customer) {
        throw $this->createNotFoundException('InvoiceCustomer not found');
      }
      $address=$invoice_customer->getAddress();
      $address=explode("\n",$address);
      return $this->controller->render('DimeInvoiceBundle:Invoice:invoice.html.twig',
        array('items' => $items,
                        'sum' => $sum,
                        'customer' => $customer,
                        'address' => $address,
                        'invoice_number' => $invoice_number,
                        'vat' => $vat,
                        'brutto' => $brutto,
                        'kleinunternehmer' => 'no'));
    }
  }
}
