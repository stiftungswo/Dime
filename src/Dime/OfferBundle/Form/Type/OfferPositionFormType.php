<?php

namespace Dime\OfferBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class OfferPositionFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\OfferBundle\Entity\OfferPosition',
                'csrf_protection' => false,
                'allow_extra_fields' => true
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        
        
        $builder
            ->add('offer')
            ->add('order')
            ->add('amount')
            ->add('rateValue', 'tbbc_simple_money')
            ->add('rateUnit')
            ->add('rateUnitType')
            ->add('vat')
            ->add('discountable')
            ->add('user')
            ->add('service');
    }

    public function getName()
    {
        return 'dime_offerbundle_offerpositionformtype';
    }
}
