<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFichasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('fichas', function (Blueprint $table) {
            $table->id();
            $table->string('nombreFicha');
            $table->integer('codigoFicha');
            $table->date('fechaFin');
            $table->date('fechaCreacion');
            $table->foreignId('admin_id');
            $table->foreign('admin_id')->references('id')->on('administradores');
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
        Schema::dropIfExists('fichas');
    }
}
