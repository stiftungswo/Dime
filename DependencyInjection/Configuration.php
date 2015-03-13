<?php

namespace Dime\InvoiceBundle\DependencyInjection;

use Symfony\Component\Config\Definition\Builder\TreeBuilder;
use Symfony\Component\Config\Definition\ConfigurationInterface;

/**
 * This is the class that validates and merges configuration from your app/config files
 *
 * To learn more see {@link http://symfony.com/doc/current/cookbook/bundles/extension.html#cookbook-bundles-extension-config-class}
 */
class Configuration implements ConfigurationInterface
{
    /**
     * {@inheritDoc}
     */
    public function getConfigTreeBuilder()
    {
        $treeBuilder = new TreeBuilder();
        $rootNode = $treeBuilder->root('dime_invoice');
	    $rootNode
	    ->children()
		    ->arrayNode('sender')
		        ->children()
		            ->scalarNode('name')->end()
		            ->scalarNode('plz')->end()
		            ->scalarNode('city')->end()
		            ->scalarNode('street')->end()
		            ->scalarNode('streetnumber')->end()
		            ->scalarNode('phone')->end()
		            ->scalarNode('fax')->end()
		            ->scalarNode('mail')->end()
		            ->scalarNode('web')->end()
		            ->scalarNode('mwstId')->end()
		            ->scalarNode('bank')->end()
		            ->scalarNode('iban')->end()
		            ->scalarNode('kontoNr')->end()
		        ->end()
		    ->end()
		    ->scalarNode('mwstPercent')->end()
	    ->end();

        // Here you should define the parameters that are allowed to
        // configure your bundle. See the documentation linked above for
        // more information on that topic.

        return $treeBuilder;
    }
}
