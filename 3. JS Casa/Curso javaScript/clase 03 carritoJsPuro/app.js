let arregloProductos = [];
let carritoCompra = [];


function agregarProducto() {
    const codigos = document.getElementById("codigo").value;
    const nombres = document.getElementById("nombre").value;
    const precios = document.getElementById("precio").value;
    const cantidades = document.getElementById("cantidad").value;
    const garantias = document.getElementById("garantia").value;

    const cantidad = parseInt(cantidades);
    const precio = parseFloat(precios);

    if (codigos !== "" && nombres !== "" && precios !== "" && garantias !== "") {
        if(garantias > 1){

            let objeto = {
                codigo: codigos,
                nombre: nombres,
                precio: precio,
                cantidad: cantidad,
                garantia: garantias
            };
    
            let encontrado = arregloProductos.some(valor => valor.codigo == codigos || valor.nombre == nombres);
    
            if(!encontrado){
                arregloProductos.push(objeto);
                
                document.getElementById("codigo").value = "";
                document.getElementById("nombre").value = "";
                document.getElementById("precio").value = "";
                document.getElementById("cantidad").value ="";
                document.getElementById("garantia").value = "";
    
                recorrerProductos();
    
            }else{
    
                document.getElementById("codigo").value = "";
                document.getElementById("nombre").value = "";
                document.getElementById("precio").value = "";
                document.getElementById("cantidad").value ="";
                document.getElementById("garantia").value = "";
    
                alert("El producto ya se encuentra registrado");
            }
        }else{
                document.getElementById("codigo").value = "";
                document.getElementById("nombre").value = "";
                document.getElementById("precio").value = "";
                document.getElementById("cantidad").value ="";
                document.getElementById("garantia").value = "";
            alert("Los años de la garantía son negativos, ingresa nuevamente");
        }

    } else {
        alert("La información esta incompleta");
    }
}


function imprimir(codigo, nombre, precio, cantidad, garantia, indice) {

    const total = cantidad * precio;

    const nodoNombre = document.createTextNode(nombre);
    const nodoCodigo = document.createTextNode("Código: "+codigo);
    const nodoPrecio = document.createTextNode("Precio: "+precio);
    const nodoCantidad = document.createTextNode("Cantidad: "+cantidad);
    const nodoGarantia = document.createTextNode("Garantia: "+garantia+" años");
    const nodoTotal = document.createTextNode("Total: "+total);
    const nodoEliminar = document.createTextNode("Eliminar");
    const nodoAgregar = document.createTextNode("Agregar carrito");
    
    const h5Nombre = document.createElement("h2");
    h5Nombre.classList.add("card-text","pb-2");
    h5Nombre.appendChild(nodoNombre);
    
    const pCodigo = document.createElement("p");
    pCodigo.classList.add("card-text");
    pCodigo.appendChild(nodoCodigo);
    
    const pPrecio = document.createElement("p");
    pPrecio.classList.add("card-text");
    pPrecio.appendChild(nodoPrecio);

    const pCantidad = document.createElement("p");
    pCantidad.classList.add("card-text");
    pCantidad.appendChild(nodoCantidad);
    
    const pGarantia = document.createElement("p");
    pGarantia.classList.add("card-text");
    pGarantia.appendChild(nodoGarantia);

    const h3Total = document.createElement("h5");
    h3Total.classList.add("card-text");
    h3Total.appendChild(nodoTotal);
    
    const btnEliminar = document.createElement("button");
    btnEliminar.classList.add("btn", "btn-danger","me-2");
    btnEliminar.setAttribute("onclick", "eliminarProducto(" + indice + ")");
    btnEliminar.appendChild(nodoEliminar);

    const btnAgregar = document.createElement("button");
    btnAgregar.classList.add("btn","btn-warning");
    btnAgregar.setAttribute("onclick","carrito('"+codigo+"')");
    btnAgregar.appendChild(nodoAgregar);
    
    const primerDiv = document.createElement("div");
    primerDiv.classList.add("card-body");
    primerDiv.appendChild(h5Nombre);
    primerDiv.appendChild(pCodigo);
    primerDiv.appendChild(pPrecio);
    primerDiv.appendChild(pCantidad);
    primerDiv.appendChild(pGarantia);
    primerDiv.appendChild(h3Total);
    primerDiv.appendChild(btnEliminar);
    primerDiv.appendChild(btnAgregar);
    
    if(nombre[0] == 'G' || nombre[0] == 'g'){
        const nodoGratis = document.createTextNode("Gratis");
        const boton = document.createElement("button");
        boton.classList.add("btn","btn-secondary");
        boton.appendChild(nodoGratis);
        primerDiv.appendChild(boton);
    }

    const segundoDiv = document.createElement("div");
    segundoDiv.classList.add("card");
    segundoDiv.appendChild(primerDiv);
    
    const tercerDiv = document.createElement("div");
    tercerDiv.classList.add("col-lg-4", "col-md-4", "col-sm-6", "col-12", "mt-3");
    tercerDiv.appendChild(segundoDiv);

    const body = document.getElementById("contenedor");
    body.appendChild(tercerDiv);
}

function recorrerProductos(arreglo=arregloProductos) {

    document.getElementById("contenedor").innerHTML="";

    for (let i = 0; i < arreglo.length; i++) {
        let codigo = arreglo[i].codigo;
        let nombre = arreglo[i].nombre;
        let precio = arreglo[i].precio;
        let cantidad = arreglo[i].cantidad;
        let garantia = arreglo[i].garantia;

        imprimir(codigo, nombre, precio, cantidad, garantia, i);
    }
}

function eliminarProducto(indice) {
    arregloProductos.splice(indice, 1);
    recorrerProductos();
}

function filtrarProductos(){
    const busqueda = document.getElementById("buscador").value;

    let busquedas =arregloProductos.filter(valor=> valor.codigo == busqueda);
    recorrerProductos(busquedas);
}

function carrito(codigo){
    
    const indiceProducto = arregloProductos.findIndex(valor => valor.codigo == codigo);
    const producto = arregloProductos[indiceProducto];

    const indiceCarrito = carritoCompra.findIndex(valor => valor.codigo == codigo);

    if(indiceCarrito >= 0){
        
        if(producto.cantidad >= 1 ){
            carritoCompra[indiceCarrito].cantidad++;
        }
        
    }else{
        let objetoCarrito = {
            codigo: codigo,
            nombre: producto.nombre,
            precio: producto.precio,
            cantidad: 1,
            garantia: producto.garantia  
        };
        
        carritoCompra.push(objetoCarrito);
    }
    
    arregloProductos[indiceProducto].cantidad--;
    recorrerProductos();


    document.getElementById("contenidoCarrito").innerHTML="";

    const etq_codigo = document.createTextNode("Código");
    const etq_nombre = document.createTextNode("Nombre");
    const etq_precio = document.createTextNode("Precio");
    const etq_cantidad = document.createTextNode("Cantidad");
    const etq_garantia = document.createTextNode("Garantía");


    const tbody = document.createElement("tbody");

    const thCodigo = document.createElement("th");
    thCodigo.appendChild(etq_codigo);

    const thNombre = document.createElement("th");
    thNombre.appendChild(etq_nombre);

    const thPrecio = document.createElement("th");
    thPrecio.appendChild(etq_precio);

    const thCantidad = document.createElement("th");
    thCantidad.appendChild(etq_cantidad);

    const thGarantia= document.createElement("th");
    thGarantia.appendChild(etq_garantia);

    const trhead = document.createElement("tr");
    trhead.appendChild(thCodigo);
    trhead.appendChild(thNombre);
    trhead.appendChild(thPrecio);
    trhead.appendChild(thCantidad);
    trhead.appendChild(thGarantia);

    const thead = document.createElement("thead");
    thead.appendChild(trhead);

    const table = document.createElement("table");
    table.classList.add("table");
    table.appendChild(trhead);

    for(let producto of carritoCompra){

        const nodoCodigo = document.createTextNode(producto.codigo);
        const nodoNombre = document.createTextNode(producto.nombre);
        const nodoPrecio = document.createTextNode(producto.precio);
        const nodoCantidad = document.createTextNode(producto.cantidad);
        const nodoGarantia = document.createTextNode(producto.garantia);
    
        const tdCodigo = document.createElement("td");
        tdCodigo.appendChild(nodoCodigo);

        const tdNombre = document.createElement("td");
        tdNombre.appendChild(nodoNombre);

        const tdPrecio = document.createElement("td");
        tdPrecio.appendChild(nodoPrecio);

        const tdCantidad = document.createElement("td");
        tdCantidad.appendChild(nodoCantidad);

        const tdGarantia = document.createElement("td");
        tdGarantia.appendChild(nodoGarantia);

        const fila = document.createElement("tr");
        fila.appendChild(tdCodigo);
        fila.appendChild(tdNombre);
        fila.appendChild(tdPrecio);
        fila.appendChild(tdCantidad);
        fila.appendChild(tdGarantia);

        tbody.appendChild(fila);
    }

    table.appendChild(tbody);
    const contenidoCarrito = document.getElementById("contenidoCarrito");
    contenidoCarrito.appendChild(table);
}
