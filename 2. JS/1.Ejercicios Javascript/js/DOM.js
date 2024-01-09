let ingredientes = "";

function agregar_ingredientes() {
    //solicitando el dato y almacenandi temporalmente en variable
    let dato = prompt("nombre del ingrediente");

    //creando un item de lista html, acumulando en variable
    ingredientes += "<li>" + dato + "</li>";

    //imprimiendo la variable html ingredientes en el id lista 
    document.getElementById("lista").innerHTML = ingredientes;
}

function ingrediente_pro() {
    
    //resibir el dato del input
    let dato = document.getElementById("inp_nombre").value;
    dato = document.getElementById("inp_nombre").value = "";
   
    //crear un nodo de texto 
    let texto=document.createTextNode(dato);

    //crear el item de la lista 
    let item = documen.createElement("li");

    //al item creado anteriormente le agrego un hijo
    item.appendChild(texto);

    //asignar el elemento ul a un objeto para poder afectarlo
    const ul_pro= document.getElementById("listapro");

    //agregar hijos al ul--li

    ul_pro.appendChild(item);




}