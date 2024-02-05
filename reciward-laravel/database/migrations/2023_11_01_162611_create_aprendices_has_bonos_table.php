<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAprendicesHasBonosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('aprendices_has_bonos', function (Blueprint $table) {
            $table->id();
            $table->string('codigoValidante', 15)->unique();
            $table->boolean('estadoBono');
            $table->Date('fechaCreacion');
            $table->Date('fechaVencimiento');
            $table->foreignId('aprendiz_id');
            $table->foreign('aprendiz_id')->references('id')->on('aprendices');
            $table->foreignId('bono_id');
            $table->foreign('bono_id')->references('id')->on('bonos');
            
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('aprendices_has_bonos');
    }
}
