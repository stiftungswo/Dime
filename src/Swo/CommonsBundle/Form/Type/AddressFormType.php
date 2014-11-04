<?php

namespace Swo\CommonsBundle\Form\Type;

use Doctrine\Common\Persistence\ObjectManager;
use Swo\CommonsBundle\Form\Transformer\AddressCityTransformer;
use Swo\CommonsBundle\Form\Transformer\AddressStreetTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

class AddressFormType extends AbstractType
{
    private $om;

    public function __construct(ObjectManager $om)
    {
        $this->om = $om;
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('street', new AddressStreetFormType($this->om), array())
            ->add('streetnumber', 'text', array())
            ->add('city', new AddressCityFormType($this->om), array())
            ->add('state', new AddressStateFormType($this->om), array())
            ->add('country', new AddressCountryFormType($this->om), array());
    }

    public function getName()
    {
        return 'swo_commons_addressformtype';
    }

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'Swo\CommonsBundle\Entity\Address',
            'cascade_validation' => true,
            'translation_domain' => 'SwoCommonsBundle'
        ));
    }
}
