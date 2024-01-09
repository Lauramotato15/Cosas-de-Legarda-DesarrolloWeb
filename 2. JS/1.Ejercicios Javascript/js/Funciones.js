let total=0;

function agregarproducto() {
    let nombre= prompt ("ingrese el nombre del producto");
    let cantidad= parseInt(prompt ("cantidad"));
    let valoru= parseFloat(prompt ("ingrese valor unitario"));
    let valor_totalp= cantidad * valoru;

    let chichipata = "<tr>";
       chichipata += "<td>"+nombre+"</td>";
       chichipata += "<td>"+cantidad+"</td>";
       chichipata += "<td>"+valoru+"</td>";
       chichipata += "<td>"+valor_totalp+"</td>";
       chichipata += "</tr>";
    total = total + valor_totalp;
length
    document.getElementById("datos").innerHTML=chichipata;
    console.log(chichipata);

    document.getElementById("total_final").innerHTML="total a pagar: "+ total;

    document.getElementById("total_parcial").innerHTML= "total parcial: "+ valor_totalp;
}

function Descuento (){
    let p_Des= parseFloat(prompt("Ingrese el porcentaje de descuento"));
    let valor_descuento= total * p_Des / 100;

    document.getElementById("Descuento").innerHTML= "valor descuento: "+valor_descuento;
    total = total - valor_descuento;
    document.getElementById("total_final").innerHTML="total a pagar: "+ total;
}