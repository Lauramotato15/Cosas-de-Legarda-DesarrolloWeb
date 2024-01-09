let kilo= 9.641;
let kilos = [];
let manzanas;
let valor_descuento; 
let precioiva;


alert('el kilo de manzanas esta en $9.641');

manzanas = parseFloat(prompt("ingrese cantidad de kilos que desea comprar"));
kilos.push(manzanas * kilo);


for (let i=0; i<kilo; i++){

    if(manzanas>=0 && manzanas<=2){
       valor_descuento = 100*0;  
       precioiva= kilos - valor_descuento;
       document.getElementById("total_pagariva").innerHTML = " " + precioiva;

    }else if (manzanas>= 2,1 & manzanas <=5){ 
        valor_descuento = 100*0;     
        valor_descuento = kilos * 10 / 100;
        precioiva= kilos - valor_descuento;
        document.getElementById("total_pagariva").innerHTML = " " + precioiva;

    }else if (manzanas >=5.1 && manzanas<=10){
        valor_descuento = kilos * 10 / 100;
        valor_descuento = kilos * 15 / 100;
        precioiva= kilos - valor_descuento;
        document.getElementById("total_pagariva").innerHTML = " " + precioiva;

    }else if(manzanas >10 && manzanas<=1000) {
        valor_descuento = kilos * 15 / 100;
        valor_descuento = kilos * 20 / 100;
        precioiva= kilos - valor_descuento;
        document.getElementById("total_pagariva").innerHTML = " " + precioiva;
    }
}


document.getElementById("kilo").innerHTML= "kilos comprados :  "+ manzanas;
document.getElementById("Descuento").innerHTML= "% "+valor_descuento;

