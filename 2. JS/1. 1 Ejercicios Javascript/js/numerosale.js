let arreglo=[];
let i=0;
let promedio;
let suma=0;

console.log(suma,promedio);



while (i<20){
    let numero =  Math.random()*100;
    arreglo[i]=numero; 
    suma = suma + numero;  
    i++;   // hacer el incremento de ultimo
}

promedio = suma / arreglo.length; //length para obtener la cantidad de elementos de un arreglo 

document.write('El promedio de los numeros es: '+promedio);



