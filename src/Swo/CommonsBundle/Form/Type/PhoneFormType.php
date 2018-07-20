<?php
/**
 * Author: Till Wegmüller
 * Date: 11/4/14
 * Dime
 */

namespace Swo\CommonsBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class PhoneFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('number')
            ->add('type');
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Swo\CommonsBundle\Entity\Phone',
            'translation_domain' => 'SwoCommonsBundle'
        ));
    }
}
