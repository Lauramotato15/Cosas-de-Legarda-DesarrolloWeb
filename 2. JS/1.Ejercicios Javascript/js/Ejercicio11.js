
let multiplicacion = 1;
let i;
let negativo = true;

do {
    numero = parseInt(prompt('Ingrese numero'));

    if (numero > 0) {

        multiplicacion = multiplicacion * numero;

    } else if (numero < 0) {

        negativo = false;
    }

} while (negativo);

document.write('El resultado de la multiplicacion de todos los numeros positivos es: '+multiplicacion);


