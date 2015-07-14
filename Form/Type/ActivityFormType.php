<?php

namespace Dime\TimetrackerBundle\Form\Type;

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
        //$transformer = new ReferenceTransformer();
        $builder
            ->add('description')
            ->add('rateValue', 'tbbc_simple_money')
            ->add('chargeable')
            //->add($builder->create('chargeableReference', 'text', array('empty_data' => ActivityReference::$SERVICE))->addViewTransformer($transformer))
            //Service has to be set after Project due to Dependencies.
            ->add('project', 'entity', array('class' => 'DimeTimetrackerBundle:Project'))
	        ->add('rateUnitType', 'entity', array('class' => 'DimeTimetrackerBundle:RateUnitType'))
	        ->add('vat')
	        ->add('service', 'entity', array('class' => 'DimeTimetrackerBundle:Service'))
	        ->add('tags', 'entity', array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_activityformtype';
    }
}
