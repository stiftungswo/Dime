<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class PeriodFormType extends AbstractType
{

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\EmployeeBundle\Entity\Period',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('start', DateTimeType::class, array('required' => true, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('end', DateTimeType::class, array('required' => true, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('pensum')
            ->add('employee', EntityType::class, array('class' => 'DimeEmployeeBundle:Employee'))
            ->add('realTime')
            ->add('holidays')
            ->add('lastYearHolidayBalance')
            ->add('yearlyEmployeeVacationBudget', IntegerType::class, ['required' => true])
        ;
    }

    public function getName()
    {
        return 'dime_employeebundle_periodformtype';
    }
}
