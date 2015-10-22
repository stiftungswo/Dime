<?php

namespace Dime\FrontendBundle;

use Knp\JsonSchemaBundle\DependencyInjection\Compiler\RegisterJsonSchemasPass;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\HttpKernel\Bundle\Bundle;

class DimeFrontendBundle extends Bundle
{
    public function build(ContainerBuilder $container)
    {
        $container->addCompilerPass(new RegisterJsonSchemasPass($this));
    }
}
