<?php

namespace Swo\CustomerBundle\Form\Type;

use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;

class PersonFormType extends AbstractCustomerFormType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Swo\CustomerBundle\Entity\Person',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        parent::buildForm($builder, $options);
        $builder
            ->add('company')
            ->add('salutation')
            ->add('firstName')
            ->add('lastName')
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }
}
