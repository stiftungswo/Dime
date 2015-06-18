<?php
/**
 * Author: Till Wegmüller
 * Date: 9/26/14
 * Dime
 */

namespace Dime\InvoiceBundle\Form\Type;


use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class InvoiceDiscountFormType extends AbstractType
{
	public function buildForm(FormBuilderInterface $builder, array $options)
	{
		$builder
			->add('name')
			->add('minus', 'choice', array('empty_data' => true, 'required' => false, 'choices' => array('0' => false, '1' => true)))
			->add('percentage', 'choice', array('empty_data' => true, 'required' => false, 'choices' => array('0' => false, '1' => true)))
			->add('value')
			->add('user')
			->add('invoice')
			;
	}

	public function setDefaultOptions(OptionsResolverInterface $resolver)
	{
		$resolver->setDefaults(array(
			'data_class' => 'Dime\InvoiceBundle\Entity\InvoiceDiscount',
			'csrf_protection' => false,
			'allow_extra_fields' => true,
		));
	}


	/**
	 * Returns the name of this type.
	 *
	 * @return string The name of this type
	 */
	public function getName()
	{
		return 'dime_invoicebundle_invoicediscountformtype';
	}
}