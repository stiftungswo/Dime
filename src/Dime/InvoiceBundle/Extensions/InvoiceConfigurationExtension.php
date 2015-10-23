<?php
/**
 * Author: Till Wegmüller
 * Date: 3/9/15
 * Dime
 */

namespace Dime\InvoiceBundle\Extensions;


use Dime\InvoiceBundle\Service\InvoiceConfigurationValueReader;

class InvoiceConfigurationExtension extends \Twig_Extension {

	protected $configReader;

	function __construct(InvoiceConfigurationValueReader $configurationValueReader) {
		$this->configReader = $configurationValueReader;
	}

	public function getGlobals() {
		return array(
			'invoiceconfig' => $this->configReader
		);
	}

	/**
	 * Returns the name of the extension.
	 *
	 * @return string The extension name
	 */
	public function getName()
	{
		return 'invoiceconfig';
	}
}