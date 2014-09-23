<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Dime\TimetrackerBundle\Form\Transformer\ReferenceTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;


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
	        ->add($builder->create('rateReference')->addViewTransformer(new ReferenceTransformer()))
	        ->add('chargeable', null, array('empty_data' => 'checked', 'required' => false))
	        ->add($builder->create('chargeableReference')->addViewTransformer(new ReferenceTransformer()))
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
