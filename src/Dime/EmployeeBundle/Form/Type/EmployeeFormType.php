<?php

namespace Dime\EmployeeBundle\Form\Type;

use Dime\TimetrackerBundle\Form\Transformer\PasswordCryptTransformer;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class EmployeeFormType extends AbstractType
{
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => 'Dime\EmployeeBundle\Entity\Employee',
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
            ->add('extendTimetrack')
            ->add('workingPeriods', EntityType::class, array('class' => 'DimeEmployeeBundle:Period', 'multiple' => true))
        ;
    }
}
