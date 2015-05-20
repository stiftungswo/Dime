<?php
/**
 * Author: Till Wegmüller
 * Date: 4/17/15
 * Dime
 */

namespace Dime\EmployeeBundle\Entity;

use Carbon\Carbon;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * Class WorkingPeriod
 * @package Dime\EmployeeBundle\Entity
 * @ORM\Table("WorkingPeriods")
 * @ORM\Entity(repositoryClass="Dime\EmployeeBundle\Entity\PeriodRepository")
 */
class WorkingPeriod extends Period{
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
	 * @ORM\ManyToOne(targetEntity="Dime\EmployeeBundle\Entity\Employee", inversedBy="workingPeriods")
	 */
	protected $employee;
}