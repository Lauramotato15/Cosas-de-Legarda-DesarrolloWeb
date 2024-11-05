let carritoCompras = [

];  //matriz que contiene cada registro que se hace 


function agregarProducto() {

    const producto = document.getElementById("inputNombre").value;
    const descripcion = document.getElementById("inputDescrip").value; //Extreamos los datos
    const valor = document.getElementById("inputPrecio").value;
    const cantidad = document.getElementById("inputCantidad").value;
    const subTotal = cantidad * valor;  //Sacamos el subtotal

    if(tempo == null){   //revisamos que el indice este nulo para poder hacer un registro nuevo

        const orden = [producto, descripcion, valor, cantidad, subTotal]; //Estamos creando el arreglo y formato en el que se va a guardar
        carritoCompras.push(orden); // lo guardamos en la matriz

    }else {  //si no es porque esta lleno y podemos editar 

        carritoCompras[tempo][0] = producto;
        carritoCompras[tempo][1] = descripcion;
        carritoCompras[tempo][2] = valor;
        carritoCompras[tempo][3] = cantidad;
        carritoCompras[tempo][4] = subTotal;

        tempo = null;
    }

    document.getElementById("inputNombre").value = ""; //limpiamos los inputs
    document.getElementById("inputDescrip").value = "";
    document.getElementById("inputPrecio").value = "";
    document.getElementById("inputCantidad").value = "";

    recorreCarrito();    //recorremos el carrito para que se vaya actualizando 
}


function imprimir(producto, descrip, valorUnitario, cantidad, subTotal, indice) { //matriz de imprimir 

    const nodoProducto = document.createTextNode(producto);
    const nodoDescrip = document.createTextNode(descrip);
    const nodoPrecio = document.createTextNode(valorUnitario);
    const nodoCantidad = document.createTextNode(cantidad);       //creamos los nodos 
    const nodoSubtotal = document.createTextNode(subTotal);
    const nodoIncrementar = document.createTextNode("+");
    const nodoDisminuir = document.createTextNode("-");
    const nodoEliminar = document.createTextNode("Eliminar");
    const nodoeditar = document.createTextNode("editar");


    const tdProducto = document.createElement("td");
    tdProducto.appendChild(nodoProducto);

    const tdDescrip = document.createElement("td");
    tdDescrip.appendChild(nodoDescrip);
                                                    
    const tdPrecio = document.createElement("td");                //luego los elementos y le agregamos los hijos que son los nodos
    tdPrecio.appendChild(nodoPrecio);

    const tdCantidad = document.createElement("td");
    tdCantidad.appendChild(nodoCantidad);

    const tdSubtotal = document.createElement("td");
    tdSubtotal.appendChild(nodoSubtotal);

    const botonIncrementar = document.createElement("button");
    botonIncrementar.appendChild(nodoIncrementar);
    botonIncrementar.setAttribute("onclick", "incrementar (" + indice + ")");  //creamos los botones 

    const botonDisminuir = document.createElement("button");
    botonDisminuir.appendChild(nodoDisminuir);
    botonDisminuir.setAttribute("onclick", "decrementarCanti(" + indice + ")");

    const botonEditar = document.createElement("button");
    botonEditar.appendChild(nodoeditar);
    botonEditar.setAttribute("onclick", "seleccionado(" + indice + ")");
   

    const tdButton1 = document.createElement("td");
    tdButton1.appendChild(botonIncrementar);
    tdButton1.appendChild(botonDisminuir);

    const tdButton3 = document.createElement("td");
    tdButton3.appendChild(botonEditar);
    tdButton3.setAttribute("data-bs-toggle","modal");
    tdButton3.setAttribute("data-bs-target","#Modal1");


    const botonEliminar = document.createElement("button");
    botonEliminar.appendChild(nodoEliminar);
    botonEliminar.setAttribute("onclick", "eliminar (" + indice + ")");

    const tdEliminar = document.createElement("td");
    tdEliminar.appendChild(botonEliminar);

    const fila = document.createElement("tr");      //creamos la fila y le agregamos los hijos que son  los tds
    fila.appendChild(tdProducto);
    fila.appendChild(tdDescrip);
    fila.appendChild(tdPrecio);
    fila.appendChild(tdCantidad);
    fila.appendChild(tdSubtotal);        
    fila.appendChild(tdButton1);
    fila.appendChild(tdButton3);
    fila.appendChild(tdEliminar);

    const tbody = document.getElementById("datos");        //creamos una variable que va a contener el id, que es donde tenemos que imprimir 
    tbody.appendChild(fila);                             //le agregamos un hijo, para que se imprima todo (la tabla)
}


function recorreCarrito() {                    //Esta función es para poder recorrer toda la matriz 
    const tbody = document.getElementById("datos").innerHTML = "";     //limpiando el contendedor 

    const buscar = document.getElementById("Buscar").value; // Este es el id del buscador, estamos trayendo los datos que puso el usuario en el input buscador  
    
    for (let i = 0; i < carritoCompras.length; i++) {  //recorremos la matriz 

        const nombre = carritoCompras[i][0];
        const descripcion = carritoCompras[i][1];  //todas estas variables son auxiliares 
        const valor = carritoCompras[i][2];
        const canti = carritoCompras[i][3];
        const sub = carritoCompras[i][4];


        if (buscar != "") { //hacemos la condicional para el buscador 

            if (buscar == carritoCompras[i][0]) { 
                imprimir(nombre, descripcion, valor, canti, sub, i); //es importante imprimir cada que  se trate de un cambio
            }

        } else {

            imprimir(nombre, descripcion, valor, canti, sub, i);

        }
    }
}


function decrementarCanti(indice) {  //funcion para decrementar

    if(confirm("Seguro desea hacer esta accion")){
        if (carritoCompras[indice][3] > 0) {    //confirmamos que la cantidad no sea negativa 
            carritoCompras[indice][3] = carritoCompras[indice][3] - 1; // en el indice donde esta la cantidad le decrementamos
            carritoCompras[indice][4] = carritoCompras[indice][3] * carritoCompras[indice][2];
    
            recorreCarrito();  //Recorrer carrito, para actualizar 
        } 
    };
}

function incrementar(indice) { //funcion para incrementar 

    if(confirm("Seguro desea hacer esta accion")){
        if (carritoCompras[indice][3] >= 0) { //condicional para verificar que la cantidad no sea negativo
            carritoCompras[indice][3]++;      // miramos el indice en el que esta la cantidad e incrementamos la cantidad 
            carritoCompras[indice][4] = carritoCompras[indice][3] * carritoCompras[indice][2];  //actualizamos el subtotal
            recorreCarrito(); //siempre que hagamos un cambio, recorremos la matriz para que se actualice 
        }
    };
}

function eliminar(indice) { //para eliminar tenemos que pasar el indice por parametro 

    if(confirm("Seguro desea hacer esta accion")){

        carritoCompras.splice(indice, 1);   //luego le decimos que queremos eliminar ese indice y una sola fila
        recorreCarrito();

    };
}

let tempo = null; //Lo inicializamos en null, como vacio 

function seleccionado (indice){ //funcion para editar

    tempo = indice; //guardamos el indice en una temporal, lo necesitamos en agregar
    
    document.getElementById("inputNombre").value = carritoCompras[indice][0]; //Se traen todos los datos del producto que queremos editar
    document.getElementById("inputDescrip").value = carritoCompras[indice][1];
    document.getElementById("inputPrecio").value = carritoCompras[indice][2];;
    document.getElementById("inputCantidad").value = carritoCompras[indice][3];
    
}

