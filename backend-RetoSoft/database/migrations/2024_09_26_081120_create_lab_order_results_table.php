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
        Schema::create('lab_order_results', function (Blueprint $table) {
            $table->id('id_lab_order_result');
            $table->unsignedBigInteger('id_order');
            $table->unsignedBigInteger('id_procedure');
            $table->unsignedBigInteger('id_test');
            $table->unsignedBigInteger('id_option_test');
            $table->enum('option_result', ['bajo', 'normal', 'alto']);
            $table->float('number_result'); 
            $table->text('text_result');
            $table->text('memo_result');
            $table->integer('num_processings');
            $table->timestamp('date_result'); 

            // Claves foráneas
            $table->foreign('id_order')->references('id_order_lab')->on('lab_orders')->onDelete('cascade');
            $table->foreign('id_procedure')->references('id_lab_procedure')->on('lab_procedures')->onDelete('cascade');
            $table->foreign('id_test')->references('id_lab_test')->on('lab_tests')->onDelete('cascade');
            $table->foreign('id_option_test')->references('id_options_test_lab')->on('lab_option_tests')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lab_order_results');
    }
};
