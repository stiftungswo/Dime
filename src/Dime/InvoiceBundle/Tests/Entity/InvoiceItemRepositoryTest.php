<?php

use Dime\TimetrackerBundle\Tests\Entity\DimeRepositoryTestCase;
use Dime\InvoiceBundle\Entity\InvoiceItemRepository;

class InvoiceItemRepositoryTest extends DimeRepositoryTestCase
{
    // set up const for tests
    protected const ENTITY_NAME='DimeInvoiceBundle:InvoiceItem';
    protected const QB_ALIAS='i';

    // TESTS
    function testSearch()
    {
        // get a random item and fetch its name
        $rand_id = rand(1, 5);
        $item_name = $this->getRepoWithQB()->find($rand_id)->getName();
        $expect = count($this->getRepoWithQB()->findBy(['name' => $item_name]));

        $this->assertEquals($expect, count($this->getRepoWithQB()->search($item_name)
            ->getCurrentQueryBuilder()->getQuery()->execute()));
    }

    function testScopeWithTag()
    {
        // tags are currently not implented in InvoiceItemRepository
        $this->assertInstanceOf(
            InvoiceItemRepository::class,
            $this->getRepoWithQB()->scopeWithTag('name')
        );
    }

    function testScopeWithoutTag()
    {
        // tags are currently not implented in InvoiceItemRepository
        $this->assertInstanceOf(
            InvoiceItemRepository::class,
            $this->getRepoWithQB()->scopeWithoutTag('name')
        );
    }

    function testFilter()
    {
        // the method itselfs are tested in all other tests
        // so here we just verify that the params are passed correctly
        $invoice_discount_repository = $this->getMockBuilder(
            InvoiceItemRepository::class
        )
            ->disableOriginalConstructor()
            ->setMethods(['scopeWithTags', 'scopeWithoutTags', 'search',
                'scopeByField', 'scopeByDate'])->getMock();

        // with tags
        $invoice_discount_repository->expects($this->once())->method('scopeWithTags')
            ->with($this->equalTo('lorem ipsum'));
        $invoice_discount_repository->filter(['withTags' => 'lorem ipsum']);

        // without tags
        $invoice_discount_repository->expects($this->once())->method('scopeWithoutTags')
            ->with($this->equalTo('lorem ipsum'));
        $invoice_discount_repository->filter(['withoutTags' => 'lorem ipsum']);

        // with date
        $invoice_discount_repository->expects($this->once())->method('scopeByDate')
            ->with($this->equalTo('lorem ipsum'));
        $invoice_discount_repository->filter(['date' => 'lorem ipsum']);

        // with search
        $invoice_discount_repository->expects($this->once())->method('search')
            ->with($this->equalTo('lorem ipsum'));
        $invoice_discount_repository->filter(['search' => 'lorem ipsum']);

        // default
        $invoice_discount_repository->expects($this->once())->method('scopeByField')
            ->with(
                $this->equalTo('name'),
                $this->equalTo('lorem ipsum')
            );
        $invoice_discount_repository->filter(['name' => 'lorem ipsum']);
    }

    function testScopeByDate()
    {
        // tags are currently not implented in InvoiceItemRepository
        $this->assertInstanceOf(
            InvoiceItemRepository::class,
            $this->getRepoWithQB()->scopeByDate('2018-07-06')
        );
    }
}
