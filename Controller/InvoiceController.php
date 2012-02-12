<?php

namespace Dime\InvoiceBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;


class InvoiceController extends Controller
{
  
  public function indexAction()
  {
    $customers = $this->getDoctrine()->getRepository('DimeTimetrackerBundle:Customer')->findAll();
    if (!$customers) {
      throw $this->createNotFoundException('No customer found');
    }
    return $this->render('DimeInvoiceBundle:Invoice:index.html.twig', array('customers' => $customers));
  }

  
  public function activitiesAction($customer_id, Request $request)
  {
    $activities = $this->getDoctrine()->getRepository('DimeTimetrackerBundle:Activity')->findByCustomer($customer_id);
    if (!$activities) {
      throw $this->createNotFoundException('No activity found');
     }  
    $defaultData=array();
    $defaultData['invoice_number']='';
    foreach ($activities as $activity){
      $defaultData['description'.$activity->getId()]=$activity->getDescription();
    }
    $builder=$this->createFormBuilder($defaultData);
    $builder->add('invoice_number','text');
    foreach ($activities as $activity) {
      $builder->add('description'.$activity->getId(),'text');
      $builder->add('charge'.$activity->getId(), 'checkbox', array('required' => false));
    }
    $form=$builder->getForm();
    if ($request->getMethod() == 'POST') {
/*      
      $button_value=$this->get('request')->request->get('config-button');
      if ($button_value=='cancel') {
        return $this->redirect($this->generateUrl('DimeTimetrackerInvoiceBundle_customers'));        
      }
*/            
      $form->bindRequest($request);  
      if ($form->isValid()) {
        $items=array();  
        $data=$form->getData();
        $invoice_number=$data['invoice_number'];
        $sum=0;
        foreach ($activities as $activity){
          $charge=$data['charge'.$activity->getId()];
          if ($charge){
            $timeslices=$this->getDoctrine()->getRepository('DimeTimetrackerBundle:Timeslice')->findByActivity($activity->getId()); 
            if (!$timeslices) {
              throw $this->createNotFoundException('No timeslice found');
            }
            $duration=0;
            foreach ($timeslices as $timeslice){
              $duration+=$timeslice->getDuration();
            }  
//            $price=($activity->getDuration()*$activity->getRate())/3600;
            $price=($duration*$activity->getRate())/3600;
            $item['description']=$data['description'.$activity->getId()];
//            $item['duration']=number_format($activity->getDuration()/3600, 2);
            $item['duration']=number_format($duration/3600, 2);
            $item['rate']=number_format($activity->getRate(), 2);
            $item['price']=number_format($price, 2);
            $items[]=$item;
            $sum+=$price;
            $sum=number_format($sum, 2);
          }          
        }
        $vat=$sum*0.19;
        $brutto=$sum+$vat;
        $customer=$this->getDoctrine()->getRepository('DimeTimetrackerBundle:Customer')->find($customer_id);
        if (!$customer) {
          throw $this->createNotFoundException('Customer not found');
        } 
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
    $customer = $this->getDoctrine()->getRepository('DimeTimetrackerBundle:Customer')->find($customer_id);
    if (!$customer) {
      throw $this->createNotFoundException('Customer not found');
    }
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
/*      
      $button_value=$this->get('request')->request->get('config-button');
      if ($button_value=='cancel') {
        return $this->redirect($this->generateUrl('DimeTimetrackerInvoiceBundle_customers'));        
      }
*/            
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