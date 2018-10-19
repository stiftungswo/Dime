<?php

use App\Modules\Service\Models\ServiceRate;
use App\Modules\Service\Models\RateGroup;
use App\Modules\Service\Models\Service;
use Faker\Generator;
use Illuminate\Database\Eloquent\Factory;

/** @var Factory $factory */
$factory->define(ServiceRate::class, function (Generator $faker) {
    return [
        'rate_group_id' => factory(RateGroup::class),
        'service_id' => factory(Service::class),
        'value' => $faker->numberBetween(0, 1000),
    ];
});
