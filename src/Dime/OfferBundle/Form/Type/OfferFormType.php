<?php

namespace Dime\OfferBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class OfferFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
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
            ->add('fixedPrice')
            ->add('user')
            ->add('address', 'swo_commons_addressformtype')
            ->add('validTo', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => false))
            ->add('offerPositions')
            ->add('standardDiscounts', 'entity', array('class' => 'DimeTimetrackerBundle:StandardDiscount', 'multiple' => true));
    }

    public function getName()
    {
        return 'dime_offerbundle_offerformtype';
    }
}
