<?php

namespace Dime\OfferBundle\Form\Type;

use Swo\CommonsBundle\Form\Type\AddressFormType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Tbbc\MoneyBundle\Form\Type\SimpleMoneyType;

class OfferFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\OfferBundle\Entity\Offer',
                'csrf_protection' => false,
                'allow_extra_fields' => true
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('project')
            ->add('status')
            ->add('rateGroup')
            ->add('customer')
            ->add('accountant')
            ->add('shortDescription')
            ->add('description')
            ->add('tags')
            ->add('fixedPrice', SimpleMoneyType::class)
            ->add('user')
            ->add('address', AddressFormType::class)
            ->add('offerPositions');
    }
}
