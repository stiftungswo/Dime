<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class UserFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\TimetrackerBundle\Entity\User',
                'csrf_protection' => false,
                'allow_extra_fields' => true,
            )
        );
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('username')
            ->add('plainpassword')
            ->add('firstname')
            ->add('lastname')
            ->add('email', EmailType::class)
            ->add('enabled')
            ->add('employeeholiday')
        ;
    }
}
