<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class RateFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Rate',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('rateGroup', 'entity', array('class' => 'DimeTimetrackerBundle:RateGroup'))
            ->add('service', 'entity', array('class' => 'DimeTimetrackerBundle:Service'))
            ->add('rateUnit')
            ->add('rateValue')
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'));
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_rateformtype';
    }
}
