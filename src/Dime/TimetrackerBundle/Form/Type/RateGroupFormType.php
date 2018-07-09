<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class RateGroupFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\RateGroup',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('description')
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'));
    }
}
