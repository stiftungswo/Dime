<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Dime\TimetrackerBundle\Form\Transformer\ReferenceTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;


class StandardDiscountFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\StandardDiscount',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
	    $transformer = new ReferenceTransformer();
        $builder
            ->add('name')
            ->add('minus')
	        ->add('percentage')
            ->add('value')
            ->add('user');
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_standarddiscountformtype';
    }
}
