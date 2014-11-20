<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class CustomerFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Customer',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('alias')
	        ->add('rateGroup')
	        ->add('tags', 'entity', array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
	        ->add('chargeable', 'choice', array('empty_data' => 'empty', 'required' => false, 'choices' => array('0' => false, '1' => true)))
	        ->add('address', 'swo_commons_addressformtype')
	        ->add('phones', 'collection', array('type' => 'swo_commons_phoneformtype'))
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_customerformtype';
    }
}
