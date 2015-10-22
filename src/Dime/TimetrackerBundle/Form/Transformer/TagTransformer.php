<?php

namespace Dime\TimetrackerBundle\Form\Transformer;

use Dime\TimetrackerBundle\Entity\Tag;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\Form\DataTransformerInterface;

class TagTransformer implements DataTransformerInterface
{
    /**
     * @var ObjectManager
     */
    private $em;

    /**
     * @param ObjectManager $em
     */
    public function __construct(ObjectManager $em)
    {
        $this->em = $em;
    }

    public function transform($value)
    {
        return $value;
    }

    /**
     * Called on bind
     *
     * @param mixed $value
     * @return mixed|void
     */
    public function reverseTransform($value)
    {
        $result = array();
        if (null == $value) {
            return $result;
        }

        if (is_string($value)) {
            $value = explode(' ', $value);
        }

        $tagNames = array();
        $tagIds = array();
        foreach ($value as $tag) {
            if (is_numeric($tag)) {
                $tagIds[] = $tag;
            } else {
                $tagNames[] = $tag;
            }
        }

        $repository = $this->em->getRepository('DimeTimetrackerBundle:Tag');

        if (!empty($tagIds)) {
            $qb = $repository->createQueryBuilder('t');
            $qb->andWhere(
                $qb->expr()->andX(
                    $qb->expr()->in('t.id', ':ids')
                )
            );
            $qb->setParameter('ids', $tagIds);
            $dbResults = $qb->getQuery()->getResult();
            foreach ($dbResults as $tag) {
                $result[] = $tag;
            }
        }

        if (!empty($tagNames)) {
            $qb = $repository->createQueryBuilder('t');
            $qb->andWhere(
                $qb->expr()->andX(
                    $qb->expr()->in('t.name', ':tags')
                )
            );
            $qb->setParameter('tags', $tagNames);
            $existingTags = array();
            $dbResults = $qb->getQuery()->getResult();
            foreach ($dbResults as $tag) {
                $result[] = $tag;
                $existingTags[] = $tag->getName();
            }

            $missingTags = array_diff($tagNames, $existingTags);
            if (count($missingTags) > 0) {
                foreach ($missingTags as $name) {
                    $name = trim($name);
                    if (!empty($name)) {
                        $newTag = new Tag();
                        $newTag->setName($name);
                        $result[] = $newTag;
                    }
                }
            }
        }
        return $result;
    }
}
