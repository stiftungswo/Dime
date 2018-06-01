<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Swo\CommonsBundle\Form\Type\AddressFormType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class CustomerFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Customer',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('salutation')
            ->add('department')
            ->add('company')
            ->add('fullname')
            ->add('email')
            ->add('phone')
            ->add('alias', null, array('required' => false))
            ->add('rateGroup')
            ->add('tags', EntityType::class, array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('chargeable')
            ->add('systemCustomer')
            ->add('address', AddressFormType::class)
            ->add('phones', CollectionType::class, array('type' => 'swo_commons_phoneformtype'))
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_customerformtype';
    }
}
