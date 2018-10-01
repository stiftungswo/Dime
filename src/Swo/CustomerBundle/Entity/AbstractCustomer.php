<?php

namespace Swo\CustomerBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation as JMS;
use Dime\TimetrackerBundle\Entity\Entity;

abstract class AbstractCustomer extends Entity
{
    /**
     * @var string|null $comment
     * @ORM\Column(name="comment", type="text", nullable=true)
     */
    protected $comment;

    /**
     * @var string|null $email
     * @ORM\Column(name="email", type="text", nullable=true)
     * @JMS\Groups({"List"})
     */
    protected $email;

    /**
     * @var boolean|null $chargeable
     * @ORM\Column(name="chargeable", type="boolean", nullable=true)
     */
    protected $chargeable = true;

    /**
     * Don't show this customer in menus for address selection for offers, invoices and projects
     * @var bool|null $hideForBusiness
     * @ORM\Column(name="hide_for_business", type="boolean", nullable=true)
     * @JMS\SerializedName("hideForBusiness")
     */
    protected $hideForBusiness = false;

    /**
     * @return string|null
     */
    public function getComment()
    {
        return $this->comment;
    }

    /**
     * @param string $comment
     * @return AbstractCustomer
     */
    public function setComment(string $comment) : AbstractCustomer
    {
        $this->comment = $comment;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * @param string $email
     * @return AbstractCustomer
     */
    public function setEmail(string $email) : AbstractCustomer
    {
        $this->email = $email;
        return $this;
    }

    /**
     * @param $chargeable
     * @return AbstractCustomer
     */
    public function setChargeable($chargeable) : AbstractCustomer
    {
        $this->chargeable = $chargeable;
        return $this;
    }

    public function setHideForBusiness($hideForBusiness) : AbstractCustomer
    {
        $this->hideForBusiness = $hideForBusiness;
        return $this;
    }
}
