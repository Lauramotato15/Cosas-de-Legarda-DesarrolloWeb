let num1 = parseInt (prompt ('Ingrese numero 1'));
let num2 = parseInt (prompt ('Ingrese numero 2'));
let num3 = parseInt (prompt ('Ingrese numero 3'));

if (num1>num2 && num1>num3){
    console.log('El numero mayor es '+num1+'');

    if (num2>num3){
        console.log('El numero del medio es '+num2+'');  
        
    }else{
        console.log('El numero menor es '+num3+''); 
    }
}

if (num2>num1 && num2>num3){
    console.log('El numero mayor es '+num2+'');

    if (num1>num3){
        console.log('El numero del medio es '+num1+'');  
       
    }else{
        console.log('El numero menor es '+num1+''); 
    }

}

if (num3>num1 && num3>num2){
    console.log('El numero mayor es '+num3+'');

    if (num2>num1){
        console.log('El numero del medio es '+num2+'');  
    }else{ 
        console.log('El numero menor es '+num2+''); 
    }
}

if (num1==num2 && num1==num3 && num2==num3){
    console.log('todos son iguales');

}else if(num2==num1){
    console.log (''+num1+' y '+num2+' son iguales ');

}else if (num1==num3){
    console.log (''+num1+' y '+num3+' son iguales ');

}else if (num2==num3){
    console.log (''+num3+' y '+num2+' son iguales ');
}

