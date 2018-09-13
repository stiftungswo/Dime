<?php

namespace Swo\CustomerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class AddressFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Swo\CustomerBundle\Entity\Address',
            'translation_domain' => 'CustomerBundle'
        ));
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('street')
            ->add('supplement')
            ->add('plz')
            ->add('city')
            ->add('country')
        ;
    }
}
