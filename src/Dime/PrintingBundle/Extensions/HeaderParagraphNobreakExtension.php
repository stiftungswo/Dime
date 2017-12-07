<?php

namespace Dime\PrintingBundle\Extensions;


class HeaderParagraphNobreakExtension extends \Twig_Extension
{
	public function getFilters()
	{
		return array(
			new \Twig_SimpleFilter('hpnobreak', array($this, 'filter'), array('is_safe' => array('html')))
		);
	}

	public function filter($string)
	{
		//$string = str_replace("\n", "", $string);
		$string = "<div>" . $string . "</div>";
		$xml = simplexml_load_string($string);
		$dom = dom_import_simplexml($xml);
		$doc = new \DOMDocument('1.0');
		$newRoot = $doc->createElement("div");
		$newRoot = $doc->appendChild($newRoot);
		$node = $dom->firstChild;
		while($node->nextSibling != null){
			$myNode = $doc->importNode($node, true);
			switch($myNode->nodeName){
				case "h1":
				case "h2":
				case "h3":
					$container = $doc->createElement("div");
					$container->setAttribute("class", "nobreak");
					$container->appendChild($myNode);

					do{
						//skip over text nodes
						//TOOD if a document ends with a heading this will crash
						$node = $node->nextSibling; 
					} while (!($node instanceof \DOMElement));
					$myNode = $doc->importNode($node, true);
					$container->appendChild($myNode);

					$newRoot->appendChild($container);
				break;
				default:
					$newRoot->appendChild($myNode);
			}
			$node = $node->nextSibling;
		}
		return $doc->saveHTML();
		//return print_r($xml,true);
	}

	/**
	 * Returns the name of the extension.
	 *
	 * @return string The extension name
	 */
	public function getName()
	{
		return 'header_paragraph_nobreak_extension';
	}
}