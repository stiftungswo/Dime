<?php

namespace Dime\InvoiceBundle\TimeTrackerServiceClient;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;


/**
 * 
 * Right now only a helper class for Controllers of the InvoiceBundle
 * manages the communication with the TimeTrackerBundle API vi Buzz
 * it will be more
 * the Controller parameter for the constructror has to  be elliminated yet
 * @author jeti
 *
 */
class TimeTrackerServiceClient
{
  protected $ctrl;

  /**
   *
   * The class has to know the calling Controller (yet)
   * @param Controller $ctrl
   */
  public function __construct(Controller $ctrl)
  {
    $this->ctrl=$ctrl;
  }

  /**
   * 
   * manages the communication (the heart of the class)
   * @param string $route
   * @param int $id
   */
  public function getAPIResult($route, $id=null)
  {
    $con_request=$this->ctrl->getRequest();
    if ($id)
      $url=$this->ctrl->generateUrl($route, array('id' => $id));
    else
      $url=$this->ctrl->generateUrl($route);
    $request = $this->ctrl->get('buzz_request');
    $request->setResource($url);
    $request->setHost($con_request->getScheme().'://'.$con_request->getHost());
    $response = $this->ctrl->get('buzz_response');
    $client = $this->ctrl->get('buzz_filecontents');
    $client->send($request, $response);
    $data = json_decode($response->getContent(), true);
    return $data;
  }

  /**
   * 
   * Helper function 
   * queries activities by customer
   * @param int $customer_id
   */
  public function activitiesByCustomer($customer_id)
  {
    $data = $this->getAPIResult('get_activities');
    $activities=array();
    foreach ($data as $actdat) {
      if ($actdat['customer']['id'] == $customer_id) {
        $activities[]=$actdat;
      }
    }
    return $activities;
  }

  /**
   * 
   * Helper function
   * queries timeslices by activity
   * @param int $activity_id
   */
  public function timeslicesByActivity($activity_id)
  {
    $data = $this->getAPIResult('get_timeslices');
    $timceslices=array();
    foreach ($data as $slicedat) {
      if ($slicedat['activity']['id'] == $activity_id) {
        $timceslices[]=$slicedat;
      }
    }
    return $timceslices;
  }

}
