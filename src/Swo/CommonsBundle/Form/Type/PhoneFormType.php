<?php
/**
 * Author: Till Wegmüller
 * Date: 11/4/14
 * Dime
 */

namespace Swo\CommonsBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class PhoneFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('number')
            ->add('category')
            ->add('company', EntityType::class, array('class' => 'SwoCustomerBundle:Company'))
            ->add('persons', EntityType::class, array('class' => 'SwoCustomerBundle:Person', 'multiple' => true))
            ->add('user', EntityType::class, array('class' => 'DimeTimetrackerBundle:User'));
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Swo\CommonsBundle\Entity\Phone',
            'translation_domain' => 'SwoCommonsBundle',
            'allow_extra_fields' => true,
            'csrf_protection' => false,
        ));
    }
}
