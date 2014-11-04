<?php

namespace Swo\CommonsBundle\Form\Type;

use Doctrine\Common\Persistence\ObjectManager;
use Swo\CommonsBundle\Form\Transformer\AddressCountryTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class AddressCountryFormType extends AbstractType
{
	private $om;

	public function __construct(ObjectManager $om)
	{
		$this->om = $om;
	}

	/*
	* (non-PHPdoc)
	* @see \Symfony\Component\Form\AbstractType::buildForm()
	*/
	public function buildForm(FormBuilderInterface $builder, array $options)
	{
		$builder->addViewTransformer(new AddressCountryTransformer($this->om));
	}

	public function getParent()
	{
		return 'text';
	}

	/*
	* (non-PHPdoc)
	* @see \Symfony\Component\Form\FormTypeInterface::getName()
	*/
	public function getName()
	{
		return 'swo_commons_address_countryformytpe';
	}
	/*
	* (non-PHPdoc)
	* @see \Symfony\Component\Form\AbstractType::setDefaultOptions()
	*/
	public function setDefaultOptions(OptionsResolverInterface $resolver)
	{
		$resolver->setDefaults(array(
			'data_class' => null,
			'cascade_validation' => true
		));
	}
}