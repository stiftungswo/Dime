<?php
/**
 * Author: Till Wegmüller
 * Date: 6/11/15
 * Dime
 */

namespace Dime\ReportBundle\Handler;

use PHPPdf\Core\Node\Container;
use Symfony\Component\DependencyInjection\ContainerAware;

class ReportHandler extends ContainerAware{

	public function __construct(Container $container)
	{
		$this->container = $container;
	}

	public function getExpenseReport(array $params){
		return '';
	}

}