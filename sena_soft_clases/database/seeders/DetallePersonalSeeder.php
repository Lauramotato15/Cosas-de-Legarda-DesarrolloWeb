<?php

namespace Database\Seeders;

use App\Models\DetallePersonal;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DetallePersonalSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DetallePersonal::factory()->count(10)->create();
    }
}
