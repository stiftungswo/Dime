<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Dime\TimetrackerBundle\Form\Transformer\DurationTransformer;
use Dime\TimetrackerBundle\Form\Transformer\ReferenceTransformer;
use Dime\TimetrackerBundle\Model\ActivityReference;
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
	    $transformer = new ReferenceTransformer();
        $builder
            ->add('description')
            ->add('rate')
	        ->add('chargeable', null, array('required' => false))
	        ->add($builder->create('chargeableReference', 'text', array('empty_data' => ActivityReference::$SERVICE))->addViewTransformer($transformer))
	        ->add($builder->create('value', 'text')->addViewTransformer(new DurationTransformer()))
            ->add('service', 'entity', array('class' => 'DimeTimetrackerBundle:Service'))
            ->add('project', 'entity', array('class' => 'DimeTimetrackerBundle:Project'))
	        ->add('tags', 'entity', array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_activityformtype';
    }
}
