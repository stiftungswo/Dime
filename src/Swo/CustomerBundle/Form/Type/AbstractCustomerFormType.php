<?php

namespace Swo\CustomerBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;

abstract class AbstractCustomerFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('address', AddressFormType::class)
            ->add('rateGroup', EntityType::class, array('class' => 'DimeTimetrackerBundle:RateGroup'))
            ->add('alias')
            ->add('systemCustomer')
            ->add('email')
        ;
    }
}
