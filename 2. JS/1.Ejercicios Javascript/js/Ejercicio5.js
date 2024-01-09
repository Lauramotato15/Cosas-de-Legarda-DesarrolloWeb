let vocal = prompt('ingrese una vocal');

if (vocal && vocal.length === 1){

    if (vocal=='a' || vocal=='A' ){
        document.write('Aguila-angel');

    }else if (vocal=='e'|| vocal=='E'){
        document.write('Elefante-escoba');

    }else if(vocal=='i' || vocal=='I'){
        document.write('Iguana-isla');

    }else if (vocal=='o' || vocal=='O'){
        document.write('Oso-olla');

    }else if (vocal=='u'|| vocal=='U'){
        document.write('Utencilio-urraca');

    }else{
        document.write('escribe una vocal correcta');
    }

}else{
    document.write('Muchos caracteres ingresados');
}