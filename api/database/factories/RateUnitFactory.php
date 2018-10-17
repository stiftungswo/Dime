<?php

use App\Modules\Service\Models\RateUnit;
use Faker\Generator;
use Illuminate\Database\Eloquent\Factory;

/** @var Factory $factory */
$factory->define(RateUnit::class, function (Generator $faker) {
    return [
        'unit' => $faker->lexify("CHF/??"),
        'factor' => $faker->optional(0.5, 1)->numberBetween(1, 1000),
        'archived' => $faker->randomElement([true, false, false, false, false]),
    ];
});

