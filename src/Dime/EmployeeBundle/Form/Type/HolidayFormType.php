<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Form\Type;

use Dime\TimetrackerBundle\Form\Transformer\DurationTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class HolidayFormType extends AbstractType
{

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\EmployeeBundle\Entity\Holiday',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('date', DateTimeType::class, array('required' => true, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('duration', TextType::class)
        ;
    }

    public function getName()
    {
        return 'dime_employeebundle_holidayformtype';
    }
}
