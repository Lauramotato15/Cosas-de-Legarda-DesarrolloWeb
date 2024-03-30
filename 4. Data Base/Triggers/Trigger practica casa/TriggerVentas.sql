--Trigger para actualizar el stock de productos después de una venta:
--Después de insertar una nueva venta en la tabla de Ventas, se actualizará automáticamente el stock del producto vendido.

--Trigger para calcular el total de una venta antes de insertarla:
--Antes de insertar una nueva venta en la tabla de Ventas, se calculará automáticamente el total basado en la cantidad y el precio del producto.

--Trigger para verificar el stock antes de realizar una venta:
--Antes de insertar una nueva venta en la tabla de Ventas, se verificará si hay suficiente stock disponible del producto deseado. Si no hay suficiente stock, se cancelará la venta.

--Trigger para mantener actualizado el número de ventas realizadas por un empleado:
--Después de insertar una nueva venta en la tabla de Ventas, se incrementará automáticamente el número de ventas realizadas por el empleado asociado a esa venta en la tabla Empleados.

--Trigger para registrar cambios en los datos de los clientes:
--Después de actualizar un cliente en la tabla de Clientes, se registrará automáticamente en un registro de auditoría los cambios realizados, incluyendo los campos modificados y la fecha/hora de la modificación.

--Trigger para eliminar ventas asociadas a un producto eliminado:
--Antes de eliminar un producto de la tabla de Productos, se eliminarán automáticamente todas las ventas asociadas a ese producto en la tabla de Ventas.

--Trigger para bloquear la eliminación de un empleado con ventas asociadas:
--Antes de eliminar un empleado de la tabla de Empleados, se verificará si el empleado tiene ventas asociadas en la tabla de Ventas. Si hay ventas asociadas, se cancelará la eliminación del empleado.

--Trigger para recalcular el total de una venta después de actualizar la cantidad de productos:
--Después de actualizar la cantidad de un producto en una venta en la tabla de Ventas, se recalculará automáticamente el total de la venta basado en la nueva cantidad y el precio del producto.

--Trigger para verificar el stock después de editar una venta:
--Después de actualizar una venta en la tabla de Ventas, se verificará si hay suficiente stock disponible del producto modificado. Si la cantidad modificada excede el stock disponible, se revertirá la modificación y se mostrará un mensaje de error.

--Trigger para mantener actualizado el número de ventas realizadas por un empleado después de eliminar una venta:
--Después de eliminar una venta de la tabla de Ventas, se decrementará automáticamente el número de ventas realizadas por el empleado asociado a esa venta en la tabla Empleados.

--Trigger para registrar cambios en los datos de los clientes después de editar:
--Después de actualizar un cliente en la tabla de Clientes, se registrará automáticamente en un registro de auditoría los cambios realizados, incluyendo los campos modificados y la fecha/hora de la modificación.

--Trigger para mantener actualizado el total de ventas de un cliente después de eliminar una venta:
--Después de eliminar una venta de la tabla de Ventas, se recalcula automáticamente el total de ventas realizadas por ese cliente y se actualiza en la tabla de Clientes.