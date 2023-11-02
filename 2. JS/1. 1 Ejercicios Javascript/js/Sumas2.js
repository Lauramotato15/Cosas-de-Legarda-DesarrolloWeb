let suma = 0;
let num2;
let num1;
let acumulador=0;


num1 = parseInt(prompt('Ingrese primer numero'));

do {
    num2 = parseInt(prompt('Ingrese segundo numero'));

    for (let i = num1 +1; i <num2; i++) {

        acumulador = acumulador + i;
    }

} while (num2 < num1);

document.write('La suma de los numeros comprendidos entre ese rango es : '+ acumulador);

