
function notas(){
let todas_notas=[];
let nota;   
let pasaron='0';
let quedaron='0';

alert('Hola, un saludo');

for (let i=1; i<=7; i++){
    nota=  parseFloat (prompt ('ingrese nota asignatura '+i+' '));
    todas_notas.push(nota);

    if (nota >=3.5 && nota<=5.0){
        pasaron++;

    }else if (nota>=0.0 && nota <=3.4) {  
        quedaron++;
    }
}

console.log ('Las asignaturas que pasaste fueron  '+ pasaron);
console.log ('Las asignaturas que perdiste fueron '+ quedaron);
}