<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class PortEmployeesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //
        Schema::table('employees', function(Blueprint $table){
            $table->string('first_name');
            $table->string('last_name');
            $table->boolean('can_login');
            $table->boolean('archived');
            $table->string('holidays_per_year')->default(null);
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('employees', function(Blueprint $table){
            $table->dropColumn('first_name');
            $table->dropColumn('last_name');
            $table->dropColumn('can_login');
            $table->dropColumn('archived');
            $table->dropColumn('holidays_per_year');
            $table->dropSoftDeletes();
        });
    }
}
