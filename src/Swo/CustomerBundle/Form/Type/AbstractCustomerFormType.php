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
            ->add('comment')
            ->add('email')
            ->add('rateGroup')
            ->add('chargeable')
            ->add('hideForBusiness')
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }
}
