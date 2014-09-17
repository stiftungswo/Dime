<?php
namespace Dime\TimetrackerBundle\Form\Transformer;

use Symfony\Component\Form\DataTransformerInterface;
use Doctrine\Common\Persistence\ObjectManager;
use FOS\UserBundle\Model\UserManagerInterface;

class PasswordCryptTransformer implements DataTransformerInterface
{
    /**
     * 
     * @var UserManagerInterface
     */
    private $userManager;
    
    /**
     * @param ObjectManager $om
     */
    public function __construct(UserManagerInterface $userManager)
    {
        $this->userManager = $userManager;
    }
    /*
     * (non-PHPdoc)
     * @see \Symfony\Component\Form\DataTransformerInterface::transform()
     */
    public function transform($password)
    {
        return $password;
    }
    
    /*
     * (non-PHPdoc)
     * @see \Symfony\Component\Form\DataTransformerInterface::reverseTransform()
     */
    public function reverseTransform($password)
    {
        //Does Login Work with this?
        $tmpuser = $this->userManager->createUser();
        $tmpuser->setPlainPassword($password);
        $this->userManager->updatePassword($tmpuser);
        return $tmpuser->getPassword();
    }
}