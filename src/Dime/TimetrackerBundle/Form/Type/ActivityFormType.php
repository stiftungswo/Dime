<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Tbbc\MoneyBundle\Form\Type\SimpleMoneyType;

class ActivityFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Activity',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        //$transformer = new ReferenceTransformer();
        $builder
            ->add('description')
            ->add('rateValue', SimpleMoneyType::class)
            ->add('rateUnit')
            ->add('chargeable')
            //->add($builder->create('chargeableReference', 'text', array('empty_data' => ActivityReference::$SERVICE))->addViewTransformer($transformer))
            //Service has to be set after Project due to Dependencies.
            ->add('project', EntityType::class, array('class' => 'DimeTimetrackerBundle:Project'))
            ->add('rateUnitType', EntityType::class, array('class' => 'DimeTimetrackerBundle:RateUnitType'))
            ->add('vat')
            ->add('service', EntityType::class, array('class' => 'DimeTimetrackerBundle:Service'))
            ->add('tags', EntityType::class, array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }
}
