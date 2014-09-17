<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;
use Doctrine\ORM\EntityManager;
use Dime\TimetrackerBundle\Form\Transformer\PasswordCryptTransformer;
use FOS\UserBundle\Model\UserManagerInterface;

class UserFormType extends AbstractType
{
    
    private $userManager;
    
    public function __construct(UserManagerInterface $userManager)
    {
        $this->userManager = $userManager;
    }
    
    public function setDefaultOptions(OptionsResolverInterface $resolver)
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
        $transformer = new PasswordCryptTransformer($this->userManager);
        $builder
            ->add('username')
            ->add($builder->create('pasword', 'text')
                ->addViewTransformer($transformer))
            ->add('firstname')
            ->add('lastname')
            ->add('email', 'email')
        ;
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_userformtype';
    }
}
