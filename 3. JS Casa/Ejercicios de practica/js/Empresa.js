let auxiliarCantidad;
let auxiliarVoto;
let himalaya = 0;
let lomas = 0;
let colpatria = 0;
let girasol = 0;
let total = 0;
let c1, c2, c3, c4;


function guardarDatos(eleccion, cantidad) {
    auxiliarVoto = eleccion;
    auxiliarCantidad = cantidad;
    
    if(eleccion == 'Colpatria'){
        colpatria = colpatria + cantidad;
    }

    if(eleccion == 'Himalaya'){
        himalaya = himalaya + cantidad;
    }

    if (eleccion == 'Lomas'){
        lomas = lomas + cantidad;
    }

    if (eleccion == 'Girasoles'){
        girasol = girasol + cantidad;
    }
}



function mostrarVotos (){

    const cuerpo1 = document.getElementById("cuerpo1").innerHTML = colpatria;
    
    const cuerpo2 = document.getElementById("cuerpo2").innerHTML = himalaya;

    const cuerpo3 = document.getElementById("cuerpo3").innerHTML = lomas;

    const cuerpo4 = document.getElementById("cuerpo4").innerHTML = girasol;
}



function imprimir1() {
    const input = document.getElementById("inputNombre").value;

    const nombre = document.createTextNode(input);
    const restaurante = document.createTextNode(auxiliarVoto);
    const canVotos= document.createTextNode(auxiliarCantidad);


    const columna1 = document.createElement("td");
    columna1.appendChild(nombre);

    const columna2 = document.createElement("td");
    columna2.appendChild(restaurante);

    const columna3 = document.createElement("td");
    columna3.appendChild(canVotos);

    let fila = document.createElement("tr");
    fila.appendChild(columna1);
    fila.appendChild(columna2);
    fila.appendChild(columna3);

    const tbody = document.getElementById("datos");
    tbody.appendChild(fila);

    total = total + auxiliarCantidad;
    
    const totalito = document.createTextNode(total);

    const tdTotal = document.createElement("td");
    tdTotal.appendChild(totalito);

    const trTotal = document.createElement("tr");
    trTotal.appendChild(tdTotal);

    const footer = document.getElementById("saldo").innerHTML = total;

    document.getElementById("inputNombre").value="";

    mostrarVotos();
}

