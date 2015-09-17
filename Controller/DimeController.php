<?php

namespace Dime\TimetrackerBundle\Controller;

use FOS\RestBundle\Controller\FOSRestController;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Symfony\Component\Security\Core\User\UserInterface;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;

class DimeController extends FOSRestController
{
	protected $currentUser = null;

	/**
	 * Get the current user
	 *
	 * @return \Dime\TimetrackerBundle\Entity\User
	 */
	protected function getCurrentUser()
	{
		$user = $this->container->get('security.context')->getToken()->getUser();
		if (!is_object($user) || !$user instanceof UserInterface) {
			throw new AccessDeniedException(
				'This user does not have access to this section.');
		}

		return $user;
	}

	/**
	 * Fetch a Entity or throw an 404 Exception.
	 *
	 * @param mixed $id
	 *
	 * @param       $service
	 *
	 * @return DimeEntityInterface
	 *
	 */
	protected function getOr404($id, $service)
	{
		if (! ($entity = $this->container->get($service)->get($id))) {
			throw new NotFoundHttpException(sprintf('The resource \'%s\' was not found.', $id));
		}
		return $entity;
	}

}
