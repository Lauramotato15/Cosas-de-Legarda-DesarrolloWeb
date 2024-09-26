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
        Schema::table('users', function (Blueprint $table) {
            $table->unsignedBigInteger('id_type_document')->nullable(true) ;
            $table->string('document', 25);
            $table->string('lastname', 50); 
            $table->unsignedBigInteger('id_sex'); 
            $table->string('phone_number', 13);
            $table->string('direccion', 10);

            // Claves foráneas
            $table->foreign('id_type_document')->references('id_category_option')->on('category_options')->onDelete('cascade');
            $table->foreign('id_sex')->references('id_category_option')->on('category_options')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['id_type_document']);
            $table->dropForeign(['id_sex']);
            $table->dropColumn('id_type_document');
            $table->dropColumn('id_sex');
            $table->dropColumn('document');
            $table->dropColumn('lastname');
            $table->dropColumn('phone_number');
            $table->dropColumn('direccion');
        });
    }
};
