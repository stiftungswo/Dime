<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;
use Dime\TimetrackerBundle\Entity\User;
use Dime\TimetrackerBundle\Form\Transfomer\TagTransformer;

class ActivityFormType extends AbstractType
{
    public function setDefaultOptions(OptionsResolverInterface $resolver)
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
        $builder
            ->add('description')
            ->add('rate')
            ->add('rateReference')  // TODO: add constraints
            ->add('service')
            ->add('customer')
            ->add('project')
            ->add('tags')
            ->add('user')
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_activityformtype';
    }
}
