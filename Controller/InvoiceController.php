<?php

namespace Dime\InvoiceBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Dime\InvoiceBundle\TimeTrackerServiceClient\TimeTrackerServiceClient;

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
      $form->bindRequest($request);
      if ($form->isValid()) {
        $items=array();
        $data=$form->getData();
        $invoice_number=$data['invoice_number'];
        $sum=0;
        foreach ($activities as $activity){
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
        $customer = $tscl->getAPIResult('get_customer',$customer_id);
        $invoice_customer=$this->getDoctrine()->getRepository('DimeInvoiceBundle:InvoiceCustomer')->findOneByCoreId($customer_id);
        if (!$invoice_customer) {
          throw $this->createNotFoundException('InvoiceCustomer not found');
        }
        $address=$invoice_customer->getAddress();
        $address=explode("\n",$address);
        return $this->render('DimeInvoiceBundle:Invoice:invoice.html.twig',
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
      $form->bindRequest($request);
      if ($form->isValid()) {
        $data=$form->getData();
        $address=$data['address'];
        $invoice_customer->setAddress($address);
        $em = $this->getDoctrine()->getEntityManager();
        $em->persist($invoice_customer);
        $em->flush();
      }
      return $this->redirect($this->generateUrl('DimeInvoiceBundle_customers'));
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