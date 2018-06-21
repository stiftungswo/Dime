<?php

namespace Dime\TimetrackerBundle\Form\Type;

use Dime\TimetrackerBundle\Entity\ProjectComment;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class ProjectCommentFormType extends AbstractType
{

    /**
     * @inheritDoc
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('comment', TextType::class, ['required' => true])
            ->add('date', DateTimeType::class, ['required' => true, 'widget' => 'single_text', 'with_seconds' => true])
            ->add('project')
            ->add('user')
        ;
    }

    /**
     * @inheritDoc
     */
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults([
            'data_class' => ProjectComment::class,
            'csrf_protection' => false,
            'allow_extra_fields' => true,
        ]);
    }

    /**
     * @inheritDoc
     */
    public function getName()
    {
        return 'dime_invoicebundle_projectcommentformtype';
    }
}
