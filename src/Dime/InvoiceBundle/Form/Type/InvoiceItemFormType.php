<?php
/**
 * Author: Till Wegmüller
 * Date: 9/26/14
 * Dime
 */

namespace Dime\InvoiceBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;
use Tbbc\MoneyBundle\Form\Type\SimpleMoneyType;

class InvoiceItemFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('order', NumberType::class, ['empty_data' => '0'])
            ->add('name')
            ->add('rateValue', SimpleMoneyType::class)
            ->add('activity', EntityType::class, array('class' => 'Dime\TimetrackerBundle\Entity\Activity'))
            ->add('amount', NumberType::class)
            ->add('rateUnit')
            ->add('vat')
            ->add('invoice', EntityType::class, array('class' => 'DimeInvoiceBundle:Invoice'))
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
