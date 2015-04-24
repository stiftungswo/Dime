<?php
/**
 * Author: Till Wegmüller
 * Date: 3/31/15
 * Dime
 */

namespace Dime\EmployeeBundle\Form\Type;


use Symfony\Component\Form\AbstractType;
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
			->add('start', 'date')
			->add('end', 'date')
		;
	}

	public function getName()
	{
		return 'dime_employeebundle_periodformtype';
	}
}