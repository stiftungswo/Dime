<?php
namespace Dime\InvoiceBundle\Form\Type;


use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class InvoiceCostgroupFormType extends AbstractType
{
	public function buildForm(FormBuilderInterface $builder, array $options)
	{
		$builder
			->add('weight')
			->add('costgroup')
			->add('invoice')
			;
	}

	public function setDefaultOptions(OptionsResolverInterface $resolver)
	{
		$resolver->setDefaults(array(
			'data_class' => 'Dime\InvoiceBundle\Entity\InvoiceCostgroup',
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
		return 'dime_invoicebundle_invoicecostgroupformtype';
	}
}