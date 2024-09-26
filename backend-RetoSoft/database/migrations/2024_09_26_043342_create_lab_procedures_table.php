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
        Schema::create('lab_procedures', function (Blueprint $table) {
            $table->id('id_lab_procedure');
            $table->unsignedBigInteger('id_procedure_code');
            $table->unsignedBigInteger('id_lab_group');
            $table->string('metodo', 50);
            $table->foreign('id_procedure_code')->references('id_procedure_code')->on('procedure_codes')->onDelete('cascade');
            $table->foreign('id_lab_group')->references('id_lab_group')->on('lab_groups')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lab_procedures');
    }
};
