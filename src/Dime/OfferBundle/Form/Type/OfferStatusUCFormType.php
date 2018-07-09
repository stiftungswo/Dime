<?php

namespace Dime\OfferBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class OfferStatusUCFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\OfferBundle\Entity\OfferStatusUC',
                'csrf_protection' => false,
                'allow_extra_fields' => true
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('text')
            ->add('user')
            ->add('active');
    }
}
