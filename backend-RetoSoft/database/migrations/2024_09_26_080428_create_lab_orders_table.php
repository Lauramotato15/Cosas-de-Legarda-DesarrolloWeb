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
        Schema::create('lab_orders', function (Blueprint $table) {
            $table->id('id_order_lab'); 
            $table->unsignedBigInteger('id_user'); 
            $table->string('professional', 50);
            $table->integer('orders');
            $table->date('date_order');

            // Definición de la clave foránea
            $table->foreign('id_user')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lab_orders');
    }
};
