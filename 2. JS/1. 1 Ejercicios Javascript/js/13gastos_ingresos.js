let nombreingreso="";
let valoringreso=0;

let nombregasto="";
let valorgasto=0;

let saldo_total=0;
let restante=0;


function guardarIngreso(){

    nombreingreso=document.getElementById("nombreingreso").value;
    valoringreso= document.getElementById("valoringreso").value;
    valoringreso=parseFloat(valoringreso);

    const nombre= document.createTextNode(nombreingreso);
    const valor = document.createTextNode(valoringreso);

    const td_nombre = document.createElement('td');
    const td_valor = document.createElement('td');

    td_nombre.appendChild(nombre);
    td_valor.appendChild(valor);

    const fila = document.createElement('tr');
    fila.appendChild(td_nombre);
    fila.appendChild(td_valor);

    const tbody= document.getElementById("datos");
    tbody.appendChild(fila);

    saldo_total+= valoringreso;

    const th_saldo= document.getElementById("saldo");
    th_saldo.innerHTML = (saldo_total);

    document.getElementById("nombreingreso").value = "";
    document.getElementById("valoringreso").value = "";
}

saldo_total+= valoringreso;

function guardargasto(){

    nombregasto=document.getElementById("nombregasto").value
    valorgasto = document.getElementById("valorgasto").value;
    valorgasto =parseFloat(valorgasto);

    const nombre = document.createTextNode(nombregasto);
    const valor = document.createTextNode(valorgasto);

    const td_nombre = document.createElement('td');
    const td_valor = document.createElement('td');

    td_nombre.appendChild(nombre);
    td_valor.appendChild(valor);

    const fila = document.createElement('tr');
    fila.appendChild(td_nombre);
    fila.appendChild(td_valor);

    const tbody= document.getElementById("datos");
    tbody.appendChild(fila);

    restante = saldo_total - valorgasto;
    saldo_total = restante;

    const th_saldo= document.getElementById("saldo");
    th_saldo.innerHTML = (restante);

    document.getElementById("nombregasto").value = "";
    document.getElementById("valorgasto").value = "";
    
}



function actualizar_barras1(){
    let porcentaje= (valorgasto / saldo_total) * 100; //porcentaje 
    let text_porcen= porcentaje + "%";

    const barra= document.getElementById ("barragasto");
    barra.style.width = text_porcen;
}

function actualizar_barras2(){
    let porcentaje= (valorgasto / saldo_total) * 100; //porcentaje 
    let text_porcen= porcentaje + "%";

    const barra= document.getElementById ("barragasto");
    barra.style.width = text_porcen;
}