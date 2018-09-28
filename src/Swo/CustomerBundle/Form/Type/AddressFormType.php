<?php

namespace Swo\CustomerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;

class AddressFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Swo\CustomerBundle\Entity\Address',
            'translation_domain' => 'CustomerBundle',
            'csrf_protection' => false,
        ));
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('street')
            ->add('supplement')
            ->add('postcode')
            ->add('city')
            ->add('country')
            ->add('company')
            ->add('person')
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }
}
