<?php

namespace Dime\EmployeeBundle\Form\Type;

use Dime\TimetrackerBundle\Form\Transformer\PasswordCryptTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class EmployeeFormType extends AbstractType
{   
    public function setDefaultOptions(OptionsResolverInterface $resolver)
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
            ->add('email', 'email')
            ->add('enabled')
            ->add('locked')
	        ->add('workingPeriods', 'entity', array('class' => 'DimeEmployeeBundle:Period', 'multiple' => true))
        ;
    }

    public function getName()
    {
        return 'dime_employeebundle_employeeformtype';
    }
}
