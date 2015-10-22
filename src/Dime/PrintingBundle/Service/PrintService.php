<?php
/**
 * Author: Till Wegmüller
 * Date: 11/11/14
 * Dime
 */

namespace Dime\PrintingBundle\Service;


use PHPPdf\Cache\Cache;
use PHPPdf\Core\FacadeBuilder;
use Symfony\Bundle\TwigBundle\TwigEngine;
use Symfony\Component\HttpFoundation\Response;


class PrintService
{
	private $templating;

	private $pdfFacadeBuilder;

	private $cache;

	public function __construct(TwigEngine $templating, FacadeBuilder $facadeBuilder, Cache $cache)
	{
		$this->templating = $templating;
		$this->pdfFacadeBuilder = $facadeBuilder;
		$this->cache = $cache;
	}

	public function render($view, $parameters = array(), $stylesheet = '', $headers = array(), $docparserType = 'xml', $cache = false)
	{
		$response = new Response();
		$stylesheetContent = null;
		$responseContent = null;
		if($stylesheet != '') {
			$stylesheetContent = $this->templating->render($stylesheet);
		}
		$pdfContent = $this->templating->render($view, $parameters);
		try {

			if($cache)
			{
				$cacheKey = md5($responseContent.$stylesheetContent);
				if($this->cache->test($cacheKey))
				{
					$responseContent = $this->cache->load($cacheKey);
				}
			}
			if($responseContent === null) {
				$facade          = $this->pdfFacadeBuilder->setDocumentParserType($docparserType)->build();
				$responseContent = $facade->render($pdfContent, $stylesheetContent);
				if($cache)
				{
					$this->cache->save($pdfContent, $cacheKey);
				}
			}
		}
		catch(\Exception $e)
		{
			$response->headers->set('content-type', 'text/html');
			throw $e;
		}
		foreach($headers as $key => $value)
		{
			$response->headers->set($key, $value);
		}
		$response->headers->set('content-type', 'application/pdf');
		$response->setContent($responseContent);
		return $response;
	}
} 