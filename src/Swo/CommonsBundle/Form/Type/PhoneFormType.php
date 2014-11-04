<?php
/**
 * Author: Till Wegmüller
 * Date: 11/4/14
 * Dime
 */

namespace Swo\CommonsBundle\Form\Type;


use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class PhoneFormType extends AbstractType
{
	public function buildForm(FormBuilderInterface $builder, array $options)
	{
		$builder
			->add('number')
			->add('type');
	}

	public function getName()
	{
		return 'swo_commons_phoneformtype';
	}

	public function setDefaultOptions(OptionsResolverInterface $resolver)
	{
		$resolver->setDefaults(array(
			'data_class' => 'Swo\CommonsBundle\Entity\Phone',
			'cascade_validation' => true,
			'translation_domain' => 'SwoCommonsBundle'
		));
	}
} 