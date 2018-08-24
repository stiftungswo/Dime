<?php

namespace Dime\OfferBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Tbbc\MoneyBundle\Form\Type\SimpleMoneyType;

class OfferPositionFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
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
            ->add('rateValue', SimpleMoneyType::class)
            ->add('rateUnit')
            ->add('rateUnitType')
            ->add('vat')
            ->add('user')
            ->add('service');
    }
}
