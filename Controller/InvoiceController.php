<?php

namespace Dime\InvoiceBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Buzz\Message\Request as BuzzRequest;
use Buzz\Message\Response as BuzzResponse;
use Buzz\Client\FileGetContents as BuzzFileGetContents;



class InvoiceController extends Controller
{
  private function timetrackerService($route, $id=null)
  {
    $con_request=$this->getRequest();
    if ($id)
      $url=$this->generateUrl($route, array('id' => $id));
    else 
      $url=$this->generateUrl($route);    
    $request = new BuzzRequest('GET', $url, $con_request->getScheme().'://'.$con_request->getHost());
    $request->addHeader('Authorization: Basic '.base64_encode($con_request->getUser().':'.$con_request->getPassword()));
    $response = new BuzzResponse();    
    $client = new BuzzFileGetContents();
    $client->send($request, $response);
    $data = json_decode($response->getContent(), true);
    return $data;
  }
  
  private function activitiesByCustomer($customer_id) 
  {
    $data=$this->timetrackerService('get_activities');
    $activities=array();
    foreach ($data as $actdat) {
      if ($actdat['customer']['id'] == $customer_id) {
        $activities[]=$actdat;
      }
    }
    return $activities;
  }
  
  private function timeslicesByActivity($activity_id) 
  {
    $data=$this->timetrackerService('get_timeslices');
    $timceslices=array();
    foreach ($data as $slicedat) {
      if ($slicedat['activity']['id'] == $activity_id) {
        $timceslices[]=$slicedat;
      }
    }
    return $timceslices;
  }
  
  public function indexAction()
  {
    $data=$this->timetrackerService('get_customers');
    return $this->render('DimeInvoiceBundle:Invoice:index.html.twig', array('customers' => $data));
  }

  public function activitiesAction($customer_id, Request $request)
  {
    $activities = $this->activitiesByCustomer($customer_id);  
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
            $timeslices=$this->timeslicesByActivity($activity['id']);            
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
        $customer=$this->timetrackerService('get_customer',$customer_id);         
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
                    array(	'form' => $form->createView(), 
    						'customer_id' => $customer_id, 
    						'activities'=>$activities));
  } 

  
  public function configAction($customer_id, Request $request)
  {
    $customer=$this->timetrackerService('get_customer',$customer_id);         
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

  public function firstAction()
  {
    return $this->render('DimeInvoiceBundle:Invoice:first.html.twig');
  }
}