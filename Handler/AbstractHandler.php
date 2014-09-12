<?php
namespace Dime\TimetrackerBundle\Handler;

use Doctrine\Common\Persistence\ObjectManager;
use Dime\TimetrackerBundle\Model\DimeEntityInterface;
use Dime\TimetrackerBundle\Exception\InvalidFormException;
use Symfony\Component\Form\FormFactoryInterface;

abstract class AbstractHandler
{

    protected $om;

    protected $entityClass;

    protected $repository;

    protected $formFactory;

    public function __construct(ObjectManager $om, $entityClass, FormFactoryInterface $formFactory)
    {
        $this->om = $om;
        $this->entityClass = $entityClass;
        $this->repository = $this->om->getRepository($this->entityClass);
        $this->formFactory = $formFactory;
    }

    protected function newClassInstance()
    {
        return new $this->entityClass();
    }

    /**
     * Processes the form.
     *
     * @param array $parameters            
     * @param String $method            
     *
     * @return PageInterface
     *
     * @throws \Dime\TimetrackerBundle\Exception\InvalidFormException
     */
    protected function processForm(DimeEntityInterface $entity, array $parameters, $form, $method = "PUT", $formoptions = array())
    {
        $formoptions['method'] = $method;
        $form = $this->formFactory->create($form, $entity, $formoptions);
        $form->submit($parameters, 'PUT' !== $method);
        if ($form->isValid()) {
            $entity = $form->getData();
            $this->om->persist($entity);
            $this->om->flush($entity);
            return $entity;
        }
        throw new InvalidFormException('Invalid submitted data', $form);
    }

    protected function deleteEntity(DimeEntityInterface $entity)
    {
        $this->om->remove($entity);
        $this->om->flush();
    }
}