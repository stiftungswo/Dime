<?php

namespace Swo\CommonsBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class AddressFormType extends AbstractType
{
	public function buildForm(FormBuilderInterface $builder, array $options)
	{
		$builder->add('street')
			->add('streetnumber')
			->add('plz')
			->add('city')
			->add('state')
			->add('country');
	}

	public function getName()
	{
		return 'swo_commons_addressformtype';
	}

	public function setDefaultOptions(OptionsResolverInterface $resolver)
	{
		$resolver->setDefaults(array(
			'data_class' => 'Swo\CommonsBundle\Entity\Address',
			'cascade_validation' => true,
			'translation_domain' => 'SwoCommonsBundle'
		));
	}
}