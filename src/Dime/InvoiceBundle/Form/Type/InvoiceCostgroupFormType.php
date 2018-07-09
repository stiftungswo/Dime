<?php
namespace Dime\InvoiceBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

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

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Dime\InvoiceBundle\Entity\InvoiceCostgroup',
            'csrf_protection' => false,
            'allow_extra_fields' => true,
        ));
    }
}
