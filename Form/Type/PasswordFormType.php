<?php
namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Dime\TimetrackerBundle\Form\Transformer\PasswordCryptTransformer;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class PasswordFormType extends AbstractType
{
    protected $passwordencrpttransformer;
    
    public function __construct(PasswordCryptTransformer $passwordencrpttransformer)
    {
        $this->passwordencrpttransformer = $passwordencrpttransformer;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->addViewTransformer($this->passwordencrpttransformer, true);
    }
    
    public function getParent()
    {
        return 'password';
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_passwordformtype';
    }
}