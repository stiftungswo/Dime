<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\TimetrackerBundle\Annotation;

/**
 * Class DiscriminatorEntry
 * @package Dime\TimetrackerBundle\Annotation
 * @Annotation()
 */
class DiscriminatorEntry
{
    private $value;
    public function __construct(array $data)
    {
        $this->value = $data['value'];
    }
    public function getValue()
    {
        return $this->value;
    }
}
