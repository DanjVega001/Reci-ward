<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAprendicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('aprendices', function (Blueprint $table) {
            $table->id();
            $table->string('tipoDocumento');
            $table->integer('numeroDocumento');
            $table->string('contraseña');
            $table->string('corrreo');
            $table->foreignId('ficha_id');
            $table->foreign('ficha_id')->references('id')->on('fichas');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('aprendices');
    }
}
