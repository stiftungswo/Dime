<?php

use App\Modules\Employee\Models\Employee;
use App\Modules\Service\Models\ServiceRate;
use App\Modules\Service\Models\RateGroup;
use App\Modules\Service\Models\Service;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        app(\Faker\Generator::class)->seed();
        factory(Employee::class, 'admin')->create();
        $kanton = factory(RateGroup::class, 'kanton')->create();
        $andere = factory(RateGroup::class, 'andere')->create();

        $rateUnits = factory(\App\Modules\Service\Models\RateUnit::class)
            ->times(5)
            ->create()
            ->map(function ($r) {
                return $r['id'];
            })
            ->toArray();

        factory(Service::class)->times(10)->create()->each(function ($s) use ($kanton, $andere, $rateUnits) {

            $rateUnit = array_random($rateUnits);

            factory(ServiceRate::class)->create([
                'rate_group_id' => $kanton,
                'service_id' => $s,
                'rate_unit_id' => $rateUnit
            ]);

            factory(ServiceRate::class)->create([
                'rate_group_id' => $andere,
                'service_id' => $s,
                'rate_unit_id' => $rateUnit
            ]);
        });
    }
}
