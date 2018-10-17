<?php

use App\Modules\Service\Models\RateGroup;
use Illuminate\Database\Eloquent\Factory;

/** @var Factory $factory */
$factory->define(RateGroup::class, function (Faker\Generator $faker) {
    return [
        'name' => $faker->word,
        'description' => $faker->sentence,
    ];
});

$factory->defineAs(RateGroup::class, 'kanton', function () use ($factory) {
    $rg = $factory->raw(RateGroup::class);
    $rg['id'] = 1;
    $rg['name'] = 'Kanton';
    $rg['description'] = 'Tarif Gruppe für Kantonale Einsätze';
    return $rg;
});

$factory->defineAs(RateGroup::class, 'andere', function () use ($factory) {
    $rg = $factory->raw(RateGroup::class);
    $rg['id'] = 2;
    $rg['name'] = 'Gemeinde und Private';
    $rg['description'] = 'Tarif Gruppe für die restlichen Einsätze';
    return $rg;
});
