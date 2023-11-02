let registroProductos = [

];

function agregarProducto() {
  const producto = document.getElementById("inputProducto").value;
  const codigoBarra = document.getElementById("inputCodigo").value;
  const fechaCa = document.getElementById("inputCaducidad").value;

  const orden = [producto, codigoBarra, fechaCa];

  let existe = false;

  for (let i = 0; i < registroProductos.length; i++) {
    const codigo = registroProductos[i][1];

    if (codigo == codigoBarra) {
      existe = true;
    }
  }

  if (existe == false) {
    registroProductos.push(orden);

    document.getElementById("inputProducto").value = "";
    document.getElementById("inputCodigo").value = "";
    document.getElementById("inputCaducidad").value = "";

    recorrerArreglo();
  } else {
    alert("Este producto ya se encuentra registrado");
  }

}



/*<div class="card" style="width: 18rem;">
  <img src="..." class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div> */


function mostrarImpresion(nombre, codi, cadu) {

  const nodoProducto = document.createTextNode(nombre);
  const nodoCodigo = document.createTextNode(codi);
  const nodoFecha = document.createTextNode(cadu);
  const nodoTitle = document.createTextNode("Producto")

  const p_producto = document.createElement("p");
  p_producto.classList.add("card-text");
  p_producto.appendChild(nodoProducto);

  const p_Codigo = document.createElement("p");
  p_Codigo.classList.add("card-text");
  p_Codigo.appendChild(nodoCodigo);

  const p_Caducidad = document.createElement("p");
  p_Caducidad.classList.add("card-text");
  p_Caducidad.appendChild(nodoFecha);

  const h5Title = document.createElement("h5");
  h5Title.classList.add("card-title");
  h5Title.appendChild(nodoTitle);

  const cuerpo = document.createElement("div");
  cuerpo.classList.add("card-body");
  cuerpo.appendChild(h5Title);
  cuerpo.appendChild(p_producto);
  cuerpo.appendChild(p_Codigo);
  cuerpo.appendChild(p_Caducidad);

  const divCard = document.createElement("div");
  divCard.classList.add("card");
  divCard.appendChild(cuerpo);

  const divCol = document.createElement("div");
  divCol.classList.add("col-md-3");
  divCol.appendChild(divCard);

  const contenedor = document.getElementById("principal");
  contenedor.appendChild(divCol);

  document.getElementById("principal") = "";

}

function recorrerArreglo() {

  for (let i = 0; i < registroProductos.length; i++) {

    const auxProducto = registroProductos[i][0];
    const auxCodigo = registroProductos[i][1];
    const auxFceha = registroProductos[i][2];

    mostrarImpresion(auxProducto, auxCodigo, auxFceha);
  }
}