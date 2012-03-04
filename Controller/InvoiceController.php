<?php

namespace Dime\InvoiceBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Dime\InvoiceBundle\TimeTrackerServiceClient\TimeTrackerServiceClient;
use Dime\InvoiceBundle\Forms\ActivitiesFormProcessor;
use Dime\InvoiceBundle\Forms\ConfigFormProcessor;


class InvoiceController extends Controller
{

  /**
   *
   * generates the customer form
   * starting point of the bundle
   * therefore "indexAction"
   */
  public function indexAction()
  {
    $tscl = new TimeTrackerServiceClient($this);
    $data = $tscl->getAPIResult('get_customers');
    return $this->render('DimeInvoiceBundle:Invoice:index.html.twig', array('customers' => $data));
  }

  /**
   *
   * generates and processes the form for choosing the activities to be charged
   * @param int $customer_id
   * @param Request $request
   */
  public function activitiesAction($customer_id, Request $request)
  {
    $tscl = new TimeTrackerServiceClient($this);
    $activities = $tscl->activitiesByCustomer($customer_id);
    $defaultData=array();
    $defaultData['invoice_number']='';
    foreach ($activities as $activity){
      $defaultData['description'.$activity['id']]=$activity['description'];
    }
    $builder=$this->createFormBuilder($defaultData);
    $builder->add('invoice_number','text');
    foreach ($activities as $activity) {
      $builder->add('description'.$activity['id'],'text');
      $builder->add('charge'.$activity['id'], 'checkbox', array('required' => false));
    }
    $form=$builder->getForm();
    if ($request->getMethod() == 'POST') {
      $acfp = new ActivitiesFormProcessor($customer_id, $activities, $form, $request, $this);
      return $acfp->submitActivitiesForm();
    }
    return $this->render('DimeInvoiceBundle:Invoice:activities.html.twig',
                        array('form' => $form->createView(),
                              'customer_id' => $customer_id,
                              'activities'=>$activities));
  }

  /**
   *
   * generates and processes the form for config
   * only the customer address yet
   * other config via user customization of the template 
   * @param int $customer_id
   * @param Request $request
   */
  public function configAction($customer_id, Request $request)
  {
    $tscl = new TimeTrackerServiceClient($this);
    $customer = $tscl->getAPIResult('get_customer',$customer_id);
    $invoice_customer=$this->getDoctrine()->getRepository('DimeInvoiceBundle:InvoiceCustomer')->findOneByCoreId($customer_id);
    if (!$invoice_customer) {
      throw $this->createNotFoundException('InvoiceCustomer not found');
    }
    $address=$invoice_customer->getAddress();
    $defaultData=array('address' => $address);
    $builder=$this->createFormBuilder($defaultData);
    $builder->add('address','textarea', array('attr' => array('rows' => '5')));
    $form=$builder->getForm();
    if ($request->getMethod() == 'POST') {
      $ccfp = new ConfigFormProcessor($invoice_customer, $form, $request, $this);
      return $ccfp->submitConfigForm();      
    }
    return $this->render('DimeInvoiceBundle:Invoice:config.html.twig',
                            array('form' => $form->createView(), 'customer_id' => $customer_id,
                                  'customer' => $customer, 'address' => $address));
  }

  /**
   *
   * generates an info screen for first users
   * tells them how to custmize the invoice template
   */
  public function firstAction()
  {
    return $this->render('DimeInvoiceBundle:Invoice:first.html.twig');
  }
}