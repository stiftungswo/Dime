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

class InvoiceFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('description')
            ->add('alias')
            ->add('fixedPrice', 'tbbc_simple_money')
            ->add('project', 'entity', array('class' => 'Dime\TimetrackerBundle\Entity\Project'))
            ->add('accountant', 'entity', array('class' => 'DimeEmployeeBundle:Employee'))
            ->add('costgroup', 'entity', array('class' => 'Dime\InvoiceBundle\Entity\Costgroup'))
            ->add('customer', 'entity', array('class' => 'Dime\TimetrackerBundle\Entity\Customer'))
            ->add('start', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('end', 'datetime', array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('standardDiscounts', 'entity', array('class' => 'DimeTimetrackerBundle:StandardDiscount', 'multiple' => true))
            ->add('invoiceDiscounts', 'entity', array('class' => 'DimeInvoiceBundle:InvoiceDiscount', 'multiple' => true))
            ->add('tags', 'entity', array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('user', 'entity', array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Dime\InvoiceBundle\Entity\Invoice',
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
        return 'dime_invoicebundle_invoiceformtype';
    }
}
