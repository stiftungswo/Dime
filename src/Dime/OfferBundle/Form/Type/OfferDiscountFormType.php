<?php

namespace Dime\OfferBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class OfferDiscountFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\OfferBundle\Entity\OfferDiscount',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('minus')
            ->add('percentage')
            ->add('value')
            ->add('user')
            ->add('offer')
        ;
    }

    public function getName()
    {
        return 'dime_offerbundle_offerdiscountformtype';
    }
}
