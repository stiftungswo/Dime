<?php
/**
 * Author: Till Wegmüller
 * Date: 3/9/15
 * Dime
 */

namespace Dime\InvoiceBundle\Service;

use Symfony\Component\DependencyInjection\ContainerAware;
use Symfony\Component\DependencyInjection\ContainerInterface;

class InvoiceConfigurationValueReader extends ContainerAware {

	private $invoiceConfig;

	public function setContainer(ContainerInterface $container = NULL)
	{
		$this->container = $container;
		$this->invoiceConfig = $this->container->getParameter('invoice_config');
	}

	public function getSenderName()
	{
		return $this->invoiceConfig["sender"]["name"];
	}

	public function getSenderPlz()
	{
		return $this->invoiceConfig["sender"]["plz"];
	}

	public function getSenderCity()
	{
		return $this->invoiceConfig["sender"]["city"];
	}

	public function getSenderStreet()
	{
		return $this->invoiceConfig["sender"]["street"];
	}

	public function getSenderStreetnumber()
	{
		return $this->invoiceConfig["sender"]["streetnumber"];
	}

	public function getSenderPhone()
	{
		return $this->invoiceConfig["sender"]["phone"];
	}

	public function getSenderFax()
	{
		return $this->invoiceConfig["sender"]["fax"];
	}

	public function getSenderMail()
	{
		return $this->invoiceConfig["sender"]["mail"];
	}

	public function getSenderWeb()
	{
		return $this->invoiceConfig["sender"]["web"];
	}

	public function getSenderMwstId()
	{
		return $this->invoiceConfig["sender"]["mwstId"];
	}

	public function getSenderBank()
	{
		return $this->invoiceConfig["sender"]["bank"];
	}

	public function getSenderIban()
	{
		return $this->invoiceConfig["sender"]["iban"];
	}

	public function getSenderKontoNr()
	{
		return $this->invoiceConfig["sender"]["kontoNr"];
	}

	public function getMwstPercent()
	{
		return $this->invoiceConfig["mwstPercent"];
	}
}