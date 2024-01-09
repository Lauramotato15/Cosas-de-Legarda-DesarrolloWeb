let carrito = [

]

let total = 0;

let productoTemporal;
let precioTemporal;

function guardarProducto(producto, precio) {
    productoTemporal = producto;
    precioTemporal = precio;

}

function agregarProducto() {
    const cantidad = document.getElementById("cantidad").value;
    const subtotal = cantidad * precioTemporal;

    const registro = [productoTemporal, precioTemporal, cantidad, subtotal]; // creamos una plantilla de registro 
    carrito.push(registro);                                               // agregamos el elemento al carrito 

    mostrarcarrito();

    document.getElementById("cantidad").value = '';

}

function mostrarcarrito() {
    const body = document.getElementById("platos");
    body.innerHTML = '';
    total = 0;

    for (let i = 0; i < carrito.length; i++) {
        const producto = carrito[i][0];
        const precio = carrito[i][1];
        const cantidad = carrito[i][2];
        const subtotal = carrito[i][3];

        total += subtotal;

        const nodoPlato = document.createTextNode(producto);
        const nodoPrecio = document.createTextNode(precio);
        const nodoCantidad = document.createTextNode(cantidad);
        const nodoValor = document.createTextNode(subtotal);
        const nodoBoton = document.createTextNode("eliminar");

        const botonEliminar = document.createElement('button'); //aqui creamos el boton
        botonEliminar.appendChild(nodoBoton);                   //agregramos el texto 

        botonEliminar.addEventListener('click', function () {  /*agrega el evento click al boton eliminar y al darle click llama la funcion eliminar*/
            eliminar(i)
        });

        const columnaPlato = document.createElement('td'); //creamos la columna 
        columnaPlato.appendChild(nodoPlato);               //le agregamos el nodo como hijo

        const columnaPrecio = document.createElement('td');
        columnaPrecio.appendChild(nodoPrecio);

        const columnaCantidad = document.createElement('td');
        columnaCantidad.appendChild(nodoCantidad);

        const columnaValor = document.createElement('td');
        columnaValor.appendChild(nodoValor);

        const columnaEliminar = document.createElement('td');
        columnaEliminar.appendChild(botonEliminar);

        const fila = document.createElement('tr'); //creamos la fila (tr) y le agregamos como hijos las columnas (td)
        fila.appendChild(columnaPlato);
        fila.appendChild(columnaPrecio);
        fila.appendChild(columnaCantidad);
        fila.appendChild(columnaValor);
        fila.appendChild(columnaEliminar);

        const tbody = document.getElementById("platos"); //obtiene el elemento tbody que tiene el id platos
        tbody.appendChild(fila);                         //agregamos al tbody la fila
    }

    document.getElementById('total').innerText = total; //imprimimos el total en el elemento 
}

function eliminar(indice) {
    carrito.splice(indice, 1);
    mostrarcarrito();
}