let acumulador=1;
let es_menor=true;
do{
    let numeros = parseFloat(prompt('ingrese numeros para poder realizar la multiplicacion'));

    if(acumulador * numeros <= 5000000){
        acumulador = acumulador * numeros;
    }else{
        es_menor = false;
    }

}while(es_menor);

document.write ('el resultado de la multiplicacion es ' + acumulador);