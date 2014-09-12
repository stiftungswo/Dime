<?php

namespace Dime\TimetrackerBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Form\Form;
use FOS\RestBundle\View\View;
use Doctrine\ORM\Tools\Pagination\Paginator;
use FOS\RestBundle\Controller\FOSRestController;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

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
        if (!is_object($user) || !$user instanceof \Symfony\Component\Security\Core\User\UserInterface) {
            throw new \Symfony\Component\Security\Core\Exception\AccessDeniedException(
                'This user does not have access to this section.');
        }

        return $user;
    }
    
    /**
     * Fetch a Entity or throw an 404 Exception.
     *
     * @param mixed $id
     *
     * @return UserInterface
     *
     * @throws NotFoundHttpException
     */
    protected function getOr404($id, $service)
    {
        if (! ($user = $this->container->get($service)->get($id))) {
            throw new NotFoundHttpException(sprintf('The resource \'%s\' was not found.', $id));
        }
        return $user;
    }
}
