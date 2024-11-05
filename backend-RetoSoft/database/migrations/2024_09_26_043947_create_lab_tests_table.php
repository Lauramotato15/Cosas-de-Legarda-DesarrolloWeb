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
        Schema::create('lab_tests', function (Blueprint $table) {
            $table->id('id_lab_test');
            $table->unsignedBigInteger('id_procedure_lab');
            $table->string('code_test', 20);
            $table->string('name', 50);
            $table->unsignedBigInteger('id_result_type');
            $table->string('unit', 20);
            $table->boolean('enabled')->default(true);

            $table->foreign('id_procedure_lab')->references('id_lab_procedure')->on('lab_procedures')->onDelete('cascade');
            $table->foreign('id_result_type')->references('id_category_option')->on('category_options')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lab_tests');
    }
};
