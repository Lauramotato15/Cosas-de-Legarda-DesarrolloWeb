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
        Schema::table('estudiantes', function (Blueprint $table) {
            $table->unsignedBigInteger('id_detalle_personal')->nullable(true);
            $table->foreign('id_detalle_personal')->references('documento')->on('detalle_personals');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('estudiantes', function (Blueprint $table) {
            $table->dropForeign('[id_detalle_personal]');
            $table->dropColumn('id_detalle_personal');
        });
    }
};
