<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
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
	        ->add('doTransform', 'choice', array('empty_data' => '1', 'required' => false, 'choices' => array('0' => false, '1' => true)))
	        ->add('scale')
	        ->add('roundMode')
	        ->add('symbol')
	        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_rateunittypeformtype';
    }
}
