<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class TagFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\Tag',
                'csrf_protection' => false
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('system')
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_tagformtype';
    }
}
