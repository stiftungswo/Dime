<?php
/**
 * Author: Till Wegmüller
 * Date: 5/29/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;


use Carbon\Carbon;
use Dime\TimetrackerBundle\Entity\Entity;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use JMS\Serializer\Annotation as JMS;
use Knp\JsonSchemaBundle\Annotations as Json;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class Holiday
 * @package Dime\EmployeeBundle\Entity
 * @ORM\Table("holidays")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\HolidayRepository")
 */
class Holiday extends Entity implements DimeEntityInterface {

	/**
	 * @var Carbon
	 * @ORM\Column(type="date", nullable=true)
	 */
	protected $date;

	/**
	 * @var int
	 * Duration in Seconds
	 * @ORM\Column(type="integer", nullable=true)
	 */
	protected $duration;

	/**
	 * @return Carbon
	 */
	public function getDate()
	{
		if(is_null($this->date)){
			return null;
		}
		return Carbon::instance($this->date);
	}

	/**
	 * @param Carbon $date
	 *
	 * @return $this
	 */
	public function setDate($date)
	{
		$this->date = $date;
		return $this;
	}

	/**
	 * @return int
	 */
	public function getDuration()
	{
		return $this->duration;
	}

	/**
	 * @param int $duration
	 *
	 * @return $this
	 */
	public function setDuration($duration)
	{
		$this->duration = $duration;
		return $this;
	}


}