<?php
namespace Dime\InvoiceBundle\Forms;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Form\Form;

/**
 *
 * base class for form helper classes for the Invoice Controller
 * processes form data
 * Controller parameter has to be eliminated
 * @author jeti
 *
 */
abstract class FormProcessor
{
  protected $form;
  protected $request;
  protected $controller;

  /**
   *
   * initializes parameters needed by all form processor classes
   * @param Form $form
   * @param Request $request
   * @param Controller $controller
   */
  public function __construct(Form $form, Request $request, Controller $controller)
  {
    $this->form = $form;
    $this->request = $request;
    $this->controller = $controller;
  }
}

