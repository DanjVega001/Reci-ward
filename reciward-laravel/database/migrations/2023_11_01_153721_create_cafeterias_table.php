<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCafeteriasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cafeterias', function (Blueprint $table) {
            $table->id();
            //$table->integer('claveAcceso');
            $table->string('nombreCafeteria');
            $table->string('correoCafeteria');
            $table->string('contrasenaCafeteria');
            $table->foreignId('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            //$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('cafeterias');
    }
}
