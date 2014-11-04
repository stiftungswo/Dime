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
            ->add('tags')
	        ->add('chargeable', null, array('empty_data' => 'checked', 'required' => false))
	        ->add('address', 'swo_commons_addressformtype')
	        ->add('phones', 'swo_commons_phoneformtype')
            ->add('user')
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_customerformtype';
    }
}
