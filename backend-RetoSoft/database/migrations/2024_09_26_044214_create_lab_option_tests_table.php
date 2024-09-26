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
        Schema::create('lab_option_tests', function (Blueprint $table) {
            $table->id('id_options_test_lab');
            $table->unsignedBigInteger('id_test');
            $table->string('name', 50);
            $table->float('value_min_f');
            $table->float('value_max_f');
            $table->float('value_min_m');
            $table->float('value_max_m');

            // Definición de la clave foránea
            $table->foreign('id_test')->references('id_lab_test')->on('lab_tests')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lab_option_tests');
    }
};
