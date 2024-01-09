let productos = [];
let carrito = [];

$(() => {
    $("#botonAgregar").on("click", () => {
        let producto = {
            codigo: $("#codigo").val(),
            nombre: $("#nombre").val(),
            cantidad: $("#cantidad").val(),
            precio: $("#precio").val(),
            garantia: $("#garantia").val()
        }


        let existe = productos.some(valor => valor.codigo == producto.codigo); 
        
        if(producto.codigo != "" && producto.nombre!="" && producto.cantidad!="" && producto.precio != "" && producto.garantia!=""){
            if(producto.garantia >= 1 && producto.garantia >= 1){
                if(!existe){
                    productos.push(producto);
                }else{
                    alert("El producto ya se encuentra registrado");
                    return;
                }
            }else{
                alert("La garantia o cantidad son incorrectas");
                return;
            }
        }else{
            alert("Alguno de los campos esta vacio");
            return;
        }

        $("#codigo").val("");
        $("#nombre").val("");
        $("#cantidad").val("");
        $("#precio").val("");
        $("#garantia").val("");

        recorrer(productos);
    })
});

function recorrer(arreglo) {
    $("#contenedor").html("");
    for (i in arreglo) {
        let producto = arreglo[i];
        imprimir(producto,i);
    }
}

function imprimir(producto,i) {
    let tabla = `
        <div class="card col-lg-4 mt-3">
            <div class="card-body">
                <h5 class="card-title">${producto.nombre}</h5>
                <p>Codigo: ${producto.codigo}</p>
                <p>Cantidad: ${producto.cantidad}</p>
                <p>Precio: ${producto.precio}</p>
                <p>Garantia: ${producto.garantia}</p>
                <p>Total: ${producto.cantidad * producto.precio}</p>
                <button indice="${i}" class="btn btn-danger">Eliminar</button>
                <button agregar="agregar" data-indice="${i}" codigo="${producto.codigo}" class="btn btn-info">Agregar</button>
            </div>
        </div>
    `;
    $("#contenedor").append(tabla);
}

$("body").on("click","[indice]", function (){
    let indice = $(this).attr("indice");
    productos.splice(indice, 1);

    recorrer(productos);
});

$("body").on("click", "[data-indice]", function(){
    let {indice} = $(this).data();
    let codigo = $(this).attr("codigo");

    let productoCarrito = {
        codigo: productos[indice].codigo,
        nombre: productos[indice].nombre,
        cantidad: 1,
        precio: productos[indice].precio,
        garantia: productos[indice].garantia
    };

    if(productos[indice].cantidad < 1){
        alert("No hay cantidad disponible");
        return
    }
    let productoEnCarrito = carrito.findIndex(valor => valor.codigo == codigo);
    if(productoEnCarrito == -1){
        carrito.push(productoCarrito);
        productos[indice].cantidad--;
    }else{
        carrito[productoEnCarrito].cantidad++;
        productos[indice].cantidad--;
    }

    $("#span").html(carrito.length);
        
    recorrer(productos);
    mostrarCarrito();
});

function mostrarCarrito(){
    $("#contenidoCarrito").html("");

    let tabla = `
        <table class="table">
            <thead>
                <tr>
                    <th>Código</th> 
                    <th>Nombre</th> 
                    <th>Cantidad</th> 
                    <th>Precio</th>
                    <th>Garantia</th>  
                    <th>Editar cantidad</th>
                </tr>
            </thead>
            <tbody>
    `
    for(let i=0; i<carrito.length; i++){
       tabla+= `   
        <tr>
            <td>${carrito[i].codigo}</td> 
            <td>${carrito[i].nombre}</td> 
            <td>${carrito[i].cantidad}</td> 
            <td>${carrito[i].precio}</td>
            <td>${carrito[i].garantia}</td>
            <td>
                <button class="me-1 btn btn-danger" decremento="${i}" >-</button> <button class="btn btn-info" incrementar="${i}">+</button>
            </td>
        </tr>
        `
    }
    tabla+= `
    </tbody>
    </table>
    `
    $("#contenidoCarrito").append(tabla);
}

$("#buscador").on("click", ()=>{
    const resultado = $("#busqueda").val();
    
    if(resultado == ""){
        recorrer(productos);
    }else{
        let filtrado = productos.filter(valor =>valor.codigo == resultado);
        console.log(filtrado);
        recorrer(filtrado);
    }
});

$("body").on("click","[incrementar]", function(){
    let indiceProductoCarrito = $(this).attr("incrementar");
    
    let indiceProducto = productos.findIndex(valor => valor.codigo == carrito[indiceProductoCarrito].codigo);   

    if(indiceProducto != -1){
        carrito[indiceProductoCarrito].cantidad++;
        productos[indiceProducto].cantidad --;
        recorrer(productos);
        mostrarCarrito();
    }
});

$("body").on("click", "[decremento]", function(){
    let indiceProductoCarrito = $(this).attr("decremento");

    let indiceProducto = productos.findIndex(valor => valor.codigo == carrito[indiceProductoCarrito].codigo);

    if(indiceProducto != -1){
        if(carrito[indiceProductoCarrito].cantidad >= 1){

            carrito[indiceProductoCarrito].cantidad--;
            productos[indiceProducto].cantidad++;
            recorrer(productos);
            mostrarCarrito();

        }
        
        if(carrito[indiceProductoCarrito].cantidad <1){
            carrito.splice(indiceProductoCarrito);
            mostrarCarrito();
            $("#span").html(carrito.length);
        }
    }
})



