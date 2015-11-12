<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class TimesliceFormType extends AbstractType
{
  
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Timeslice',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('startedAt', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('stoppedAt', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('activity', 'entity', array('class' => 'DimeTimetrackerBundle:Activity'))
            //Value must be set after activity because it depends on it.
            ->add('employee', 'entity', array('class' => 'DimeEmployeeBundle:Employee'))
            ->add('value', 'text')
            ->add('tags', 'entity', array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true, 'required'=>false))
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_timesliceformtype';
    }
}
