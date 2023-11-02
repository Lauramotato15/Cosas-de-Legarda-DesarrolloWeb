let carritoCompras = [

];


let auxAnimal;
let auxPrecio;

function guardarDatos(producto, precio) {

    auxAnimal = producto;
    auxPrecio = precio;
}

function agregarCompra() {
    
    const comprador = document.getElementById("inputComprador").value;
    const cedula = document.getElementById("inputCedula").value;
    const cantidad = document.getElementById("inputCantidad").value;
    const subTotal = cantidad * auxPrecio;

    const orden = [comprador, cedula, auxAnimal, auxPrecio, cantidad, subTotal];

    let existe = false;
    let auxCedula;

    for (let i = 0; i < carritoCompras.length; i++) {
        auxCedula = carritoCompras[i][1];

        if (auxCedula == cedula) {
            existe = true;
            break;
        }
    }

    if (existe == false) {
        carritoCompras.push(orden);

        document.getElementById("inputComprador").value = "";
        document.getElementById("inputCedula").value = "";
        document.getElementById("inputCantidad").value = "";

        recorreCarrito();

    } else {
        alert("Esta cedula se encuentra registrada, no puedes comprar otra mascota (X)");
    }
}


function imprimir(comprador, cedula, mascota, valorUnitario, cantidad, subTotal, indice) {

    const nodoComprador = document.createTextNode(comprador);
    const nodoCedula = document.createTextNode(cedula);
    const nodoMascota = document.createTextNode(mascota);
    const nodoPrecio = document.createTextNode(valorUnitario);
    const nodoCantidad = document.createTextNode(cantidad);
    const nodoSubtotal = document.createTextNode(subTotal);
    const nodoIncrementar = document.createTextNode("+");
    const nodoDisminuir = document.createTextNode("-");
    const nodoEliminar = document.createTextNode("Eliminar");


    const tdComprador = document.createElement("td");
    tdComprador.appendChild(nodoComprador);

    const tdCedula = document.createElement("td");
    tdCedula.appendChild(nodoCedula);

    const tdMascota = document.createElement("td");
    tdMascota.appendChild(nodoMascota);

    const tdPrecio = document.createElement("td");
    tdPrecio.appendChild(nodoPrecio);

    const tdCantidad = document.createElement("td");
    tdCantidad.appendChild(nodoCantidad);

    const tdSubtotal = document.createElement("td");
    tdSubtotal.appendChild(nodoSubtotal);

    const botonIncrementar = document.createElement("button");
    botonIncrementar.appendChild(nodoIncrementar);
    botonIncrementar.setAttribute("onclick", "incrementar (" + indice + ")");

    const botonDisminuir = document.createElement("button");
    botonDisminuir.appendChild(nodoDisminuir);
    botonDisminuir.setAttribute("onclick", "decrementarCanti(" + indice + ")");

    const tdButton = document.createElement("td");
    tdButton.appendChild(botonIncrementar);
    tdButton.appendChild(botonDisminuir);

    const botonEliminar = document.createElement("button");
    botonEliminar.appendChild(nodoEliminar);
    botonEliminar.setAttribute("onclick", "eliminar ("+indice+")");

    const tdEliminar = document.createElement("td");
    tdEliminar.appendChild(botonEliminar);

    const fila = document.createElement("tr");
    fila.appendChild(tdComprador);
    fila.appendChild(tdCedula);
    fila.appendChild(tdMascota);
    fila.appendChild(tdPrecio);
    fila.appendChild(tdCantidad);
    fila.appendChild(tdSubtotal);
    fila.appendChild(tdButton);
    fila.appendChild(tdEliminar);

    const tbody = document.getElementById("datos");
    tbody.appendChild(fila);
}


function recorreCarrito() {

    const tbody = document.getElementById("datos").innerHTML = "";

    for (let i = 0; i < carritoCompras.length; i++) {

        const compra = carritoCompras[i][0];
        const cedu = carritoCompras[i][1];
        const masco = carritoCompras[i][2];
        const pre = carritoCompras[i][3];
        const canti = carritoCompras[i][4];
        const sub = carritoCompras[i][5];

        imprimir(compra, cedu, masco, pre, canti, sub, i);
    }
}


function decrementarCanti(indice) {

   if (carritoCompras [indice][4] > 0){
    carritoCompras[indice][4] = carritoCompras[indice][4] - 1;
    carritoCompras[indice][5] = carritoCompras[indice][4] * carritoCompras[indice][3];
    recorreCarrito();
   }
}

function incrementar(indice) {
    if (carritoCompras [indice][4] >=0){
        carritoCompras[indice][4]++;
        carritoCompras[indice][5] = carritoCompras[indice][4] * carritoCompras[indice][3];
        recorreCarrito();
    }
}

function eliminar(indice) {
    carritoCompras.splice(indice, 1);
    recorreCarrito();
}
