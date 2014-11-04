<?php
/**
 * Author: Till Wegmüller
 * Date: 10/31/14
 * Dime
 */

namespace Swo\CommonsBundle\Form\Type;

use Doctrine\Common\Persistence\ObjectManager;
use Swo\CommonsBundle\Form\Transformer\AddressStateTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class AddressStateFormType extends AbstractType
{

    private $om;

    public function __construct(ObjectManager $om)
    {
        $this->om = $om;
    }

    /*
    * (non-PHPdoc)
    * @see \Symfony\Component\Form\AbstractType::buildForm()
    */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->addViewTransformer(new AddressStateTransformer($this->om));
    }

    public function getParent()
    {
        return 'text';
    }

    /*
    * (non-PHPdoc)
    * @see \Symfony\Component\Form\FormTypeInterface::getName()
    */
    public function getName()
    {
        return 'swo_commons_address_state_formtype';
    }

    /*
    * (non-PHPdoc)
    * @see \Symfony\Component\Form\AbstractType::setDefaultOptions()
    */
    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => null,
            'cascade_validation' => true
        ));
    }
}
