<?php
/**
 * Created by PhpStorm.
 * User: toast
 * Date: 9/19/14
 * Time: 12:02 PM
 */

namespace Dime\TimetrackerBundle\Form\Type;

use Dime\TimetrackerBundle\Form\Transformer\ReferenceTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class AmountFormType extends AbstractType {
	public function setDefaultOptions(OptionsResolverInterface $resolver)
	{
		$resolver->setDefaults(
			array(
				'data_class' => 'Dime\TimetrackerBundle\Entity\Amount',
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
			->add($builder->create('rateReference', 'text')->addViewTransformer($transformer))
			->add('chargeable', null, array('empty_data' => 'checked', 'required' => false))
			->add($builder->create('chargeableReference', 'text')->addViewTransformer($transformer))
			->add('service')
			->add('customer')
			->add('project')
			->add('tags')
			->add('user')
			->add('value')
		;
	}

	public function getName()
	{
		return 'dime_timetrackerbundle_amountformtype';
	}
} 