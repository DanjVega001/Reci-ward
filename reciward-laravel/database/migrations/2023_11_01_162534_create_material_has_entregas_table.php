<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMaterialHasEntregasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('material_has_entregas', function (Blueprint $table) {
            $table->id();
            //$table->timestamps();
            $table->foreignId('material_id');
            $table->foreign('material_id')->references('id')->on('materiales');
            $table->foreignId('entrega_id');
            $table->foreign('entrega_id')->references('id')->on('entregas');
            $table->integer('numeroMaterial');
            
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('material_has_entregas');
    }
}
