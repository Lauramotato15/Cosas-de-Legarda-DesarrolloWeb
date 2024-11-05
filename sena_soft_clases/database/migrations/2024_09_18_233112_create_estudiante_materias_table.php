<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('estudiante_materias', function (Blueprint $table) {
            $table->unsignedBigInteger('id_estudiante');
            $table->unsignedBigInteger('id_materia');
            $table->date('fecha');
            $table->foreign('id_estudiante')->references('documento')->on('detalle_personals')->onDelete('cascade');
            $table->foreign('id_materia')->references('id')->on('materias')->onDelete('cascade');
            $table->timestamps();

            $table->primary(['id_estudiante', 'id_materia']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('estudiante_materias');
    }
};
