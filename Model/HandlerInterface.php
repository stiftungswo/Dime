<?php
namespace Dime\TimetrackerBundle\Model;

interface HandlerInterface
{
    /**
     * Get a Entity given the identifier
     *
     * @api
     *
     * @param mixed $id
     *
     * @return DimeEntityInterface
     */
    public function get($id);

	/**
	 * Get a list of Entities.
	 *
	 * @param array $params
	 *
	 * @return array
	 */
    public function all($params = array());
    /**
     * Post Entity, creates a new Entity.
     *
     * @api
     *
     * @param array $parameters
     * 
     * @return DimeEntityInterface
     *
    */
    public function post(array $parameters);
    /**
     * Replace data of a Entity.
     *
     * @api
     *
     * @param DimeEntityInterface $entity
     * @param array $parameters
     *
     * @return DimeEntityInterface
    */
    public function put(DimeEntityInterface $entity, array $parameters);
//     /**
//      * Partially update a Entity.
//      *
//      * @api
//      *
//      * @param DimeEntityInterface $entity
//      * @param array $parameters
//      *
//      * @return DimeEntityInterface
//     */
//     public function patch(DimeEntityInterface $entity, array $parameters);
    /**
     * Delete an Entity
     * 
     * @api
     * 
     * @param DimeEntityInterface $entity
     * 
     */
    public function delete(DimeEntityInterface $entity);
}