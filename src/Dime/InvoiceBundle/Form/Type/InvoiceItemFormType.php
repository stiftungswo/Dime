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

class InvoiceItemFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('order')
            ->add('name')
            ->add('rateValue', 'tbbc_simple_money')
            ->add('amount', 'number')
            ->add('rateUnit')
            ->add('vat')
            ->add('invoice', 'entity', array('class' => 'DimeInvoiceBundle:Invoice'))
        ;
    }

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Dime\InvoiceBundle\Entity\InvoiceItem',
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
        return 'dime_invoicebundle_invoiceitemformtype';
    }
}
