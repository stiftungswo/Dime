<?php
namespace Swo\CommonsBundle\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Component\Translation\Tests\String;
use Symfony\Component\Config\Definition\PrototypedArrayNode;
use Symfony\Component\Config\Definition\IntegerNode;

/**
 * @ORM\Entity
 * @ORM\Table(name="address_city")
\*/
class AddressCity
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;
    /**
     * The Cityname
     * @var String
     *
     * @ORM\Column(type="string")
     */
    protected $name;
    /**
     * Postleitzahl of the City
     *
     * @var integer
     *
     * @ORM\Column(type="integer")
     */
    protected $plz;

    /**
     * @return int
     */
    public function getPlz()
    {
        return $this->plz;
    }

    /**
     * @param int $plz
     *
     * @return $this
     */
    public function setPlz($plz)
    {
        $this->plz = $plz;
        return $this;
    }
    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }
    /**
     * Set name
     *
     * @param string $name
     * @return AddressCity
     */
    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }
    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }
    public function __toString()
    {
        return $this->name;
    }
}
