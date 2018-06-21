<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class RateUnitTypeFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\RateUnitType',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('id')
            ->add('name')
            ->add('factor')
            ->add('doTransform')
            ->add('scale', IntegerType::class, array('empty_data' => '3'))
            ->add('roundMode', IntegerType::class, array('empty_data' => strval(PHP_ROUND_HALF_UP)))
            ->add('symbol')
            ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_rateunittypeformtype';
    }
}
