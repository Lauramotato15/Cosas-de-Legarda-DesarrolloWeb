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
        Schema::create('category_options', function (Blueprint $table) {
            $table->id('id_category_option');
            $table->unsignedBigInteger('id_category'); 
            $table->char('abbreviation', 10); 
            $table->string('name', 50); 
            $table->boolean('enabled')->default(true); 
            $table->softDeletes();

            // Clave foránea
            $table->foreign('id_category')->references('id_category')->on('categories')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('category_options');
    }
};
