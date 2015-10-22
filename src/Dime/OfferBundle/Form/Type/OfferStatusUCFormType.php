<?php

namespace Dime\OfferBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class OfferStatusUCFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
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

    public function getName()
    {
        return 'dime_offerbundle_offerstatusucformtype';
    }
}
