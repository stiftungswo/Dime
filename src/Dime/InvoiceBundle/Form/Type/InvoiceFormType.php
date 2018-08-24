<?php
/**
 * Author: Till Wegmüller
 * Date: 9/26/14
 * Dime
 */

namespace Dime\InvoiceBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Tbbc\MoneyBundle\Form\Type\SimpleMoneyType;

class InvoiceFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('description')
            ->add('alias')
            ->add('fixedPrice', SimpleMoneyType::class)
            ->add('customer', EntityType::class, array('class' => 'Dime\TimetrackerBundle\Entity\Customer'))
            ->add('project', EntityType::class, array('class' => 'Dime\TimetrackerBundle\Entity\Project'))
            ->add('accountant', EntityType::class, array('class' => 'DimeEmployeeBundle:Employee'))
            ->add('start', DateTimeType::class, array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('end', DateTimeType::class, array('required' => false, 'widget' => 'single_text', 'with_seconds' => true))
            ->add('invoiceDiscounts', EntityType::class, array('class' => 'DimeInvoiceBundle:InvoiceDiscount', 'multiple' => true))
            ->add('tags', EntityType::class, array('class' => 'DimeTimetrackerBundle:Tag', 'multiple' => true))
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'))
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Dime\InvoiceBundle\Entity\Invoice',
            'csrf_protection' => false,
            'allow_extra_fields' => true,
        ));
    }
}
