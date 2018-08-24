<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Tbbc\MoneyBundle\Form\Type\SimpleMoneyType;

class RateFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Rate',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('rateGroup', EntityType::class, array('class' => 'DimeTimetrackerBundle:RateGroup', 'empty_data' => '1'))
            ->add('service', EntityType::class, array('class' => 'DimeTimetrackerBundle:Service'))
            ->add('rateUnitType', EntityType::class, array('class' => 'DimeTimetrackerBundle:RateUnitType'))
            ->add('rateUnit')
            ->add('rateValue', SimpleMoneyType::class)
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'));
    }
}
