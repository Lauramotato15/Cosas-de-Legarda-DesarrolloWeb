//un profesor necesita calcular el promedio de notas de un grupo de estudiantes 
//el programa debe preguntar cuantos estudiantes hay en el grupo
//luego almacenara en un arreglo la nota final de esos N estudiantes 
//luego de almacenar las notas contar cuantos pasaron y cuantos se quedaron 
//teniendo en cuenta que las notas van de 0 a 5, decimales
// y para aprobar se necesita una nota igual o mayor a 3.5
//ademas calcular el promedio del grupo imprimir los calculos

let final=[];
let nota;
let pasaron='';
let quedaron='';
let suma_notas=0;

let N_estudiantes =  parseFloat(prompt("ingrese N cantidad de estudiantes"));

for (let i=0; i<N_estudiantes; i++){

    nota=  parseFloat (prompt ("ingrese nota final"));
    final.push(nota);

    if (nota >=3.5){
        pasaron++;

    }else {  
        quedaron++;
    }
}

suma_notas+= + nota;
promedio  = suma_notas / N_estudiantes;

console.log ('Los estudiantes que pasaron fueron '+ pasaron)
console.log ('Los estudiantes que perdieron fueron  '+ quedaron)
console.log ('el promedio en total es '+ promedio);

