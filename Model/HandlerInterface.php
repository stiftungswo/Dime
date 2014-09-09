<?php
namespace Dime\TimetrackerBundle\Model;

use Dime\TimetrackerBundle\Model\DimeEntityInterface;

interface HandlerInterface
{
    /**
     * Get a Page given the identifier
     *
     * @api
     *
     * @param mixed $id
     *
     * @return PageInterface
     */
    public function get($id);
    /**
     * Get a list of Pages.
     *
     * @param int $limit the limit of the result
     * @param int $offset starting from the offset
     *
     * @return array
    */
    public function all($limit = 5, $offset = 0);
    /**
     * Post Page, creates a new Page.
     *
     * @api
     *
     * @param array $parameters
     *
     * @return PageInterface
    */
    public function post(array $parameters);
    /**
     * Edit a Page.
     *
     * @api
     *
     * @param PageInterface $page
     * @param array $parameters
     *
     * @return PageInterface
    */
    public function put(DimeEntityInterface $entity, array $parameters);
    /**
     * Partially update a Page.
     *
     * @api
     *
     * @param PageInterface $page
     * @param array $parameters
     *
     * @return PageInterface
    */
    public function patch(DimeEntityInterface $entity, array $parameters);
}