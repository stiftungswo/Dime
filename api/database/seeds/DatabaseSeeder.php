<?php

use App\Modules\Employee\Models\Employee;
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
    }
}
