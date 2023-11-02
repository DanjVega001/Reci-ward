<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEntregaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('entregas', function (Blueprint $table) {
            $table->id();
            $table->integer('cantidadMaterial');
            $table->boolean('canjeada');
            $table->integer('puntosAcumulados');
            $table->foreignId('cafeteria_id');
            $table->foreign('cafeteria_id')->references('id')->on('cafeterias');
            $table->foreignId('aprendiz_id');
            $table->foreign('aprendiz_id')->references('id')->on('aprendices');
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
        Schema::dropIfExists('entrega');
    }
}
