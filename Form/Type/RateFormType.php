<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Dime\TimetrackerBundle\Model\RateUnitType;
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
            ->add('rateGroup', 'entity', array('class' => 'DimeTimetrackerBundle:RateGroup', 'empty_data' => '1'))
            ->add('service', 'entity', array('class' => 'DimeTimetrackerBundle:Service'))
	        ->add('rateUnitType', 'choice', array('choice_list' => new RateUnitType()))
            ->add('rateUnit')
            ->add('rateValue', 'tbbc_simple_money')
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'));
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_rateformtype';
    }
}
