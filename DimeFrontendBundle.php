<?php

namespace Dime\FrontendBundle;

use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\HttpKernel\Bundle\Bundle;
use Knp\JsonSchemaBundle\DependencyInjection\Compiler\RegisterJsonSchemasPass;

class DimeFrontendBundle extends Bundle
{
	public function build(ContainerBuilder $container)
	{
		$container->addCompilerPass(new RegisterJsonSchemasPass($this));
	}
}
