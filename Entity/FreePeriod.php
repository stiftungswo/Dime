<?php
/**
 * Author: Till Wegmüller
 * Date: 4/17/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use Carbon\Carbon;

/**
 * Class WorkingPeriod
 * @package Dime\EmployeeBundle\Entity
 * @ORM\Table("FreePeriods")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\PeriodRepository")
 */
class FreePeriod extends Period{
	/**
	 * @var Carbon
	 * @ORM\Column(type="date")
	 */
	protected $start;

	/**
	 * @var Carbon
	 * @ORM\Column(type="date")
	 */
	protected $end;

	/**
	 * @var float
	 * @ORM\Column(type="decimal", nullable=true, precision=10, scale=2)
	 */
	protected $pensum;

	/**
	 * @var Employee
	 * @ORM\ManyToOne(targetEntity="Dime\EmployeeBundle\Entity\Employee", inversedBy="freePeriods")
	 */
	protected $employee;
}