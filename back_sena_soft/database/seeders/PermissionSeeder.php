<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class PermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $permisoCrear = Permission::create(['name' => 'crear usuario']);
        $permisoEditar = Permission::create(['name'=> 'editar usuario']);
        $permisoEliminar = Permission::create(['name'=> 'eliminar usuario']);
        $permisoVer = Permission::create(['name'=> 'ver usuario']);

        $administrador = Role::create(['name' => 'administrador']);
        $administrador->givePermissionTo([ $permisoCrear, $permisoEditar, $permisoVer ]);

        $user = User::find(1);
        $user->assignRole('administrador');

        ## Si el usaurio no existe 
        $user = User::create([
            'name'=> 'Laura',
            'email'=> 'lmotato@gmail.com',
            'password'=> bcrypt('12345678'),
        ]);
    }
}
