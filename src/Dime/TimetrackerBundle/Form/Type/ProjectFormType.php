<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;
use Tbbc\MoneyBundle\Form\Type\SimpleMoneyType;

class ProjectFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Project',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('rateGroup', EntityType::class, array('class' => 'DimeTimetrackerBundle:RateGroup'))
            ->add('alias', null, array('required' => false))
            ->add('accountant', EntityType::class, array('class' => 'DimeEmployeeBundle:Employee'))
            ->add('customer', EntityType::class, array('class' => 'DimeTimetrackerBundle:Customer'))
            ->add('startedAt', DateTimeType::class, array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('stoppedAt', DateTimeType::class, array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('deadline', DateTimeType::class, array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('description')
            ->add('budgetPrice', SimpleMoneyType::class)
            ->add('fixedPrice', SimpleMoneyType::class)
            ->add('budgetTime', TextType::class)
            ->add('activities', EntityType::class, array('class' => 'DimeTimetrackerBundle:Activity', 'multiple' => true))
            ->add('chargeable')
            ->add('archived')
            ->add('tags', EntityType::class, array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'))
            ->add('projectCategory', EntityType::class, array('class' => 'DimeTimetrackerBundle:ProjectCategory'))
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_projectformtype';
    }
}
