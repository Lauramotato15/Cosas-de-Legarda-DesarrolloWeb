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
        Schema::table('profesors', function (Blueprint $table) {
            $table->unsignedBigInteger('id_materia')->nullable(true);
            $table->foreign('id_materia')->references('id')->on(  'materias');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('profesors', function (Blueprint $table) {
            $table->dropForeign('[id_materia]');
            $table->dropColumn('id_materia');
        });
    }
};
