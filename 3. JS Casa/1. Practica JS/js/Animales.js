let registroMascotas = [
];

function agregarMascota() {

    const nombreAnimal = document.getElementById("inputAnimal").value;
    const especie = document.getElementById("inputEspecie").value;
    const edad = document.getElementById("inputEdad").value;

    const orden = [nombreAnimal, especie, edad];


    registroMascotas.push(orden);
    recorrerAnimales();

    document.getElementById("inputAnimal").value="";
    document.getElementById("inputEspecie").value="";
    document.getElementById("inputEdad").value="";
}

function recorrerAnimales() {
    document.getElementById("datos").innerHTML="";

    for (let i = 0; i < registroMascotas.length; i++) {
        mostrarAnimales(registroMascotas[i][0], registroMascotas[i][1], registroMascotas[i][2],i);
    }
}


function mostrarAnimales(nombreAnimal, especie, edad, indice) {

    const Nodoanimal = document.createTextNode(nombreAnimal);
    const Nodoraza = document.createTextNode(especie);
    const Nodoyears = document.createTextNode(edad);
    const NodoEliminar = document.createTextNode("eliminar");

    const columa1 = document.createElement("td");
    columa1.appendChild(Nodoanimal);

    const columna2 = document.createElement("td");
    columna2.appendChild(Nodoraza);

    const columna3 = document.createElement("td");
    columna3.appendChild(Nodoyears);

    const botonEliminar = document.createElement("button");
    botonEliminar.classList.add("btn", "btn-primary");
    botonEliminar.appendChild(NodoEliminar);
    botonEliminar.addEventListener("click", function(){
        eliminar(indice);
        recorrerAnimales();
    })

    const columna4 = document.createElement("td");
    columna4.appendChild(botonEliminar);

    const fila = document.createElement("tr");
    fila.appendChild(columa1);
    fila.appendChild(columna2);
    fila.appendChild(columna3);
    fila.appendChild(botonEliminar);


    const cuerpo = document.getElementById("datos");
    cuerpo.appendChild(fila);
}

function eliminar (i){
    registroMascotas.splice(i,1);
}

