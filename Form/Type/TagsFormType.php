<?php
namespace Dime\TimetrackerBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Dime\TimetrackerBundle\Form\Transfomer\TagTransformer;
use Doctrine\ORM\EntityManager;

class TagsFormType extends AbstractType
{
    protected $em;
    
    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->addViewTransformer(new TagTransformer($this->em, $options['user']), true);
    }
    
    public function getParent()
    {
        return 'text';
    }

    public function getName()
    {
        return 'dime_timetrackerbundle_tagsformtype';
    }
}