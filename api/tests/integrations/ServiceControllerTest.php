<?php

namespace tests\integrations;

use App\Modules\Employee\Models\Employee;
use App\Modules\Service\Models\RateGroup;
use App\Modules\Service\Models\RateUnit;
use App\Modules\Service\Models\Service;
use App\Modules\Service\Models\ServiceRate;
use Laravel\Lumen\Testing\DatabaseTransactions;

class ServiceControllerTest extends \TestCase
{

    use DatabaseTransactions;

    public function testGetServices()
    {
        factory(Service::class)->create();

        $this->asUser()->json('GET', 'api/v1/services/')
            ->seeJson()
            ->assertResponseOk();

        //TODO check if the just created service is returned
    }

    public function testGetService()
    {
        $s = factory(Service::class)->create();

        $this->asUser()->json('GET', 'api/v1/services/' . $s->id)
            ->seeJson(["name"=>$s->name])
            ->assertResponseOk();
    }

    public function testDeleteService()
    {
        $s = factory(Service::class)->create();

        $this->asUser()->json('DELETE', 'api/v1/services/' . $s->id)
            ->assertResponseOk();

        $this->assertEmpty(Service::find($s->id));
    }

    public function testCreateServiceWithServiceRate()
    {
        $rateGroup = factory(RateGroup::class)->create();
        $rateUnit = factory(RateUnit::class)->create();

        $this->asUser()->json('POST', 'api/v1/services/', [
            'name' => 'Rasen Mähen',
            'description' => 'Verkürzen der Länge von Grashalmen auf Flächen.',
            'vat' => 0.077,
            'chargeable' => true,
            'archived' => false,
            'service_rates' => [[
                'rate_group_id' => $rateGroup->id,
                'rate_unit_id' => $rateUnit->id,
                //'service_id' should be set to this new instance
                'value' => 4000
            ]]
        ]);

        $this->assertResponseOk();

        $service = Service::orderby('id', 'desc')->first();
        $this->assertStringStartsWith('Rasen', $service->name);
        $this->assertNotEmpty($service->serviceRates);
    }

    public function testUpdateServiceWithServiceRate()
    {
        $rateGroup = factory(RateGroup::class)->create([
            'name' => 'Holz Hacken'
        ]);
        $rateUnit = factory(RateUnit::class)->create();
        $service = factory(Service::class)->create();
        $serviceRate = factory(ServiceRate::class)->create([
            'rate_group_id' => $rateGroup->id,
            'rate_unit_id' => $rateUnit->id,
            'service_id' => $service->id,
            'value' => 2000
        ]);

        $this->asUser()->json('PUT', 'api/v1/services/' . $service->id, [
            'name' => 'Rasen Mähen',
            'description' => 'Verkürzen der Länge von Grashalmen auf Flächen.',
            'vat' => 0.077,
            'chargeable' => true,
            'archived' => false,
            'service_rates' => [[
                'id' => $serviceRate->id,
                'rate_group_id' => $rateGroup->id,
                'rate_unit_id' => $rateUnit->id,
                'service_id' => $service->id,
                'value' => 4000
            ]]
        ]);

        $this->assertResponseOk();

        $result = Service::find($service->id);
        $this->assertEquals('Rasen Mähen', $result->name);

        $rates = ServiceRate::where('service_id', '=', $service->id)->get();
        $this->assertCount(1, $rates);
        $this->assertEquals(4000, $rates[0]->value);
    }

    public function testUpdateServiceWithServiceRateRemoveOne()
    {
        $rateGroup = factory(RateGroup::class)->create();
        $rateGroupB = factory(RateGroup::class)->create();
        $rateUnit = factory(RateUnit::class)->create();
        $service = factory(Service::class)->create();
        $serviceRateA = factory(ServiceRate::class)->create([
            'rate_group_id' => $rateGroup->id,
            'rate_unit_id' => $rateUnit->id,
            'service_id' => $service->id,
            'value' => 2000
        ]);
        $serviceRateB = factory(ServiceRate::class)->create([
            'rate_group_id' => $rateGroupB->id,
            'rate_unit_id' => $rateUnit->id,
            'service_id' => $service->id,
            'value' => 9000
        ]);

        $this->asUser()->json('PUT', 'api/v1/services/' . $service->id, [
            'name' => $rateGroup->name,
            'description' => $rateGroup->description,
            'vat' => $rateGroup->vat,
            'chargeable' => $rateGroup->chargeable,
            'archived' => $rateGroup->archived,
            'service_rates' => [[
                'id' => $serviceRateA->id,
                'rate_group_id' => $rateGroup->id,
                'rate_unit_id' => $rateUnit->id,
                'service_id' => $service->id,
                'value' => $serviceRateA->value
            ]]
        ]);

        $this->assertResponseOk();

        $rates = ServiceRate::where('service_id', '=', $service->id)->get();
        $this->assertCount(1, $rates);
        $this->assertEquals(2000, $rates[0]->value);
    }

    public function testUpdateServiceWithServiceRateAddDuplicateRateGroup()
    {
        $rateGroup = factory(RateGroup::class)->create();
        $rateUnit = factory(RateUnit::class)->create();
        $service = factory(Service::class)->create();
        $serviceRateA = factory(ServiceRate::class)->create([
            'rate_group_id' => $rateGroup->id,
            'rate_unit_id' => $rateUnit->id,
            'service_id' => $service->id,
            'value' => 2000
        ]);

        $this->asUser()->json('PUT', 'api/v1/services/' . $service->id, [
            'name' => $rateGroup->name,
            'description' => $rateGroup->description,
            'vat' => $rateGroup->vat,
            'chargeable' => $rateGroup->chargeable,
            'archived' => $rateGroup->archived,
            'service_rates' => [[
                'id' => $serviceRateA->id,
                'rate_group_id' => $rateGroup->id,
                'rate_unit_id' => $rateUnit->id,
                'service_id' => $service->id,
                'value' => $serviceRateA->value
            ],[
                'rate_group_id' => $rateGroup->id,
                'rate_unit_id' => $rateUnit->id,
                'service_id' => $service->id,
                'value' => 9000
            ]]
        ]);

        $this->assertResponseStatus(400);

        $rates = ServiceRate::where('service_id', '=', $service->id)->get();
        $this->assertCount(1, $rates);
    }

    public function testUpdateServiceWithServiceRateAddOne()
    {
        $rateGroup = factory(RateGroup::class)->create();
        $rateGroupB = factory(RateGroup::class)->create();
        $rateUnit = factory(RateUnit::class)->create();
        $service = factory(Service::class)->create();
        $serviceRateA = factory(ServiceRate::class)->create([
            'rate_group_id' => $rateGroup->id,
            'rate_unit_id' => $rateUnit->id,
            'service_id' => $service->id,
            'value' => 2000
        ]);

        $this->asUser()->json('PUT', 'api/v1/services/' . $service->id, [
            'name' => $rateGroup->name,
            'description' => $rateGroup->description,
            'vat' => $rateGroup->vat,
            'chargeable' => $rateGroup->chargeable,
            'archived' => $rateGroup->archived,
            'service_rates' => [[
                'id' => $serviceRateA->id,
                'rate_group_id' => $rateGroup->id,
                'rate_unit_id' => $rateUnit->id,
                'service_id' => $service->id,
                'value' => $serviceRateA->value
            ],[
                'rate_group_id' => $rateGroupB->id,
                'rate_unit_id' => $rateUnit->id,
                'service_id' => $service->id,
                'value' => 9000
            ]]
        ]);

        $this->assertResponseOk();

        $rates = ServiceRate::where('service_id', '=', $service->id)->get();
        $this->assertCount(2, $rates);
    }
}
