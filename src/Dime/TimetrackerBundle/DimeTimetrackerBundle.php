<?php

namespace Dime\TimetrackerBundle;

use Knp\JsonSchemaBundle\DependencyInjection\Compiler\RegisterJsonSchemasPass;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\HttpKernel\Bundle\Bundle;

class DimeTimetrackerBundle extends Bundle
{
    public function build(ContainerBuilder $container)
    {
        $container->addCompilerPass(new RegisterJsonSchemasPass($this));
    }
}
