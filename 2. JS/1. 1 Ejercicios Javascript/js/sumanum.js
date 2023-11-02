function sumanum(){
    let suma;
    let multiplicacion;
    let resta;
    let divicion;

    let num1= parseInt(prompt('Ingrese primer numero'));
    let num2= parseInt(prompt('Ingrese segundo numero'));

    if (num1>=50 && num1<100 && num2>=50 && num2<100){
        suma= num1 + num2;
        document.write ('La suma de los dos numeros es: '+suma);

    }else if (num1>=100 && num2<100){
        multiplicacion = num1 * num2;
        document.write ('La multiplicacion de los dos numeros es: '+multiplicacion);

    }else if (num2>=100 && num1<100){
        multiplicacion = num2* num1;
        document.write ('La multiplicacion de los dos numeros es: '+multiplicacion);

    }else if(num1<50 && num2<50){
        resta= num1 - num2;
        document.write ('La resta de los dos numeros es: '+resta);

    }else if (num1>50 && num2<50){
        divicion = num1 / num2;
        document.write ('La divicion de los dos numeros es: '+divicion);

    }else if (num2>50 && num1<50){
        divicion = num1 / num2;
        document.write ('La divicion de los dos numeros es: '+divicion);
    }
}