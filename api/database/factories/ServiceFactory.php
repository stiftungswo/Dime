<?php

use App\Modules\Service\Models\Service;
use Faker\Generator;
use Illuminate\Database\Eloquent\Factory;

/** @var Factory $factory */
$factory->define(Service::class, function (Generator $faker) {
    return [
        'name' => $faker->words(3, true),
        'description' => $faker->sentence,
        'vat' => $faker->randomElement([0.025, 0.077]),
        'chargeable' => $faker->randomElement([true, false]),
        'archived' => $faker->randomElement([true, false, false, false, false]),
    ];
});

