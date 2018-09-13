<?php
/**
 * Author: Till Wegmüller
 * Date: 11/4/14
 * Dime
 */

namespace Swo\CustomerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class PhoneFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Swo\CustomerBundle\Entity\Phone',
            'translation_domain' => 'SwoCustomerBundle'
        ));
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('number')
            ->add('type')
            ->add('company', CompanyFormType::class)
        ;
    }
}
