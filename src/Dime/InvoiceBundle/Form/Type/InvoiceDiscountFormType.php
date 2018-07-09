<?php
/**
 * Author: Till Wegmüller
 * Date: 9/26/14
 * Dime
 */

namespace Dime\InvoiceBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class InvoiceDiscountFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('minus')
            ->add('percentage')
            ->add('value')
            ->add('user')
            ->add('invoice')
            ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Dime\InvoiceBundle\Entity\InvoiceDiscount',
            'csrf_protection' => false,
            'allow_extra_fields' => true,
        ));
    }
}
