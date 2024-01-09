let estudiantes = [];
let indiceEstudianteSeleccionado;

function agregarEstudiante() {
    //Traemos la información del formulario
    const nombre = document.getElementById("inputNombre").value;
    const cedula = document.getElementById("inputCedula").value;
    const ficha = document.getElementById("inputFicha").value;
    const direccion = document.getElementById("inputDireccion").value;
    const telefono = document.getElementById("inputTelefono").value;

    //creamos formato de guardado (orden)
    const registro = [nombre, cedula, ficha, direccion, telefono, []];
    let encontrado = false;

    //logica de guardado, validaciones
    for (let i = 0; i < estudiantes.length; i++) {
        const cedulaMatriz = estudiantes[i][1];

        if (cedulaMatriz == cedula) {
            encontrado = true;
        }
    }

    if (encontrado == false) {
        estudiantes.push(registro);

        document.getElementById("inputNombre").value = "";
        document.getElementById("inputCedula").value = "";
        document.getElementById("inputFicha").value = "";
        document.getElementById("inputDireccion").value = "";
        document.getElementById("inputTelefono").value = "";

        mostrarAlmacen();
    }else{
        alert("Esta cédula ya existe");
    }

}

function mostrarEstudiantes (nombre,cedula,ficha,direccion,telefono, notas, indice){

    const nodoNombre = document.createTextNode(nombre);
    const nodoCedula = document.createTextNode(cedula);
    const nodoFicha =  document.createTextNode(ficha);
    const nodoDireccion = document.createTextNode(direccion);
    const nodoTelefono = document.createTextNode(telefono);

    const pNombre = document.createElement("p");
    pNombre.appendChild(nodoNombre);
    pNombre.classList.add("card-text")
    
    const pCedula = document.createElement("p");
    pCedula.appendChild(nodoCedula);
    pCedula.classList.add("card-text");

    const pFicha = document.createElement("p");
    pFicha.appendChild(nodoFicha);
    pFicha.classList.add("card-text");

    const pDireccion = document.createElement("p");
    pDireccion.appendChild(nodoDireccion);
    pDireccion.classList.add("card-text");

    const pTelefono = document.createElement("p");
    pTelefono.appendChild(nodoTelefono);
    pTelefono.classList.add("card-text");


    const eliminar =document.createTextNode("eliminar");
    const icono = document.createElement("i");
    icono.classList.add("fa-solid", "fa-trash");
    const botonEliminar = document.createElement("button");
    botonEliminar.appendChild(eliminar);
    botonEliminar.appendChild(icono);
    botonEliminar.classList.add("btn","btn-danger");
    botonEliminar.addEventListener("click", function(){ //addEventListener añadir un escuchador de eventos
        eliminarEstudiante(indice);
    });



    const divBody= document.createElement("div");
    divBody.classList.add("card-body");
    divBody.appendChild(pNombre);
    divBody.appendChild(pCedula);
    divBody.appendChild(pFicha);
    divBody.appendChild(pDireccion);
    divBody.appendChild(pTelefono);
    divBody.appendChild(botonEliminar);

    const divCard= document.createElement("div");
    divCard.classList.add("card");
    divCard.appendChild(divBody);

    const divCol = document.createElement("div");
    divCol.classList.add("col-md-3");
    divCol.appendChild(divCard);

    const ulNotas = document.createElement("ul");
    ulNotas.classList.add("card-header");

    for (let i=0; i<notas.length; i++){
        const nota = notas [i];
        const liNota = crearNota(nota,i,indice);

        ulNotas.appendChild(liNota);
    }

    const nodoAgregar = document.createTextNode("Agregar");
    const botonAgregar = document.createElement("button");
    botonAgregar.classList.add("btn","btn-info");
    botonAgregar.appendChild(nodoAgregar);
    botonAgregar.setAttribute("data-bs-toggle","modal");
    botonAgregar.setAttribute("data-bs-target", "#modalNota");
    botonAgregar.addEventListener("click", function () {
        seleccionarEstudiante(indice);
    })



    const liBotonAgregar = document.createElement("li");
    liBotonAgregar.appendChild(botonAgregar);
    
    ulNotas.appendChild(liBotonAgregar);

    divCard.appendChild(ulNotas);


    const contenedor = document.getElementById("estudiantes");
    contenedor.appendChild(divCol);

}

function mostrarAlmacen(){
    document.getElementById("estudiantes").innerHTML = "";
    for (let i=0; i<estudiantes.length; i++){
        let nombresito = estudiantes [i][0];
        let cedulita = estudiantes [i][1];
        let fichita = estudiantes [i][2];
        let direccionsita = estudiantes [i][3];
        let telefonito= estudiantes [i][4];
        let notas = estudiantes[i][5];

        mostrarEstudiantes(nombresito, cedulita, fichita, direccionsita, telefonito, notas, i);
    }
}

function eliminarEstudiante (indice){
    estudiantes.splice(indice,1);
    mostrarAlmacen();
}

function crearNota(nota, indiceNota,indiceEstudiante){
    const icono = document.createElement("i");
    icono.classList.add("fa-solid","fa-trash");

    const botonEliminar = document.createElement("button");
    botonEliminar.classList.add("btn","btn-outline-danger");
    botonEliminar.appendChild(icono);
    botonEliminar.addEventListener("click", function (){
        eliminarNota(indiceNota, indiceEstudiante);
    })

    const nodoNota = document.createTextNode(nota);

    const li = document.createElement("li");
    li.appendChild(nodoNota);
    li.appendChild(botonEliminar);

    return li;
}

function seleccionarEstudiante (indice){
    indiceEstudianteSeleccionado = indice;
}

function guardarNota (){
    const nota = document.getElementById("inputNota").value;
    estudiantes [indiceEstudianteSeleccionado][5].push(nota);
    mostrarAlmacen();

    document.getElementById("inputNota").value="";
}

function eliminarNota (indiceNota, indiceEstudiante){
    estudiantes [indiceEstudiante][5].splice(indiceNota,1);
    mostrarAlmacen();
}