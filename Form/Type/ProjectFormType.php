<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class ProjectFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Project',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('alias', null, array('required' => false))
            ->add('customer', 'entity', array('class' => 'DimeTimetrackerBundle:Customer'))
            ->add('startedAt', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('stoppedAt', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('deadline', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('description')
            ->add('budgetPrice', 'tbbc_simple_money')
            ->add('fixedPrice', 'tbbc_simple_money')
            ->add('budgetTime')
	        ->add('activities', 'entity', array('class' => 'DimeTimetrackerBundle:Activity', 'multiple' => true))
            ->add('chargeable')
	        ->add('tags', 'entity', array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'))
            ->add('rateGroup', 'entity', array('class' => 'DimeTimetrackerBundle:RateGroup'))
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_projectformtype';
    }
}
