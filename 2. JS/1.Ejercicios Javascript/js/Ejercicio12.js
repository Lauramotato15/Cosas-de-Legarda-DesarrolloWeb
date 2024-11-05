arreglo =['mono','perro','gato','pajaro','conejo','pony'];


function imprimir (){
    let i=0;
    document.getElementById('datos').innerHTML='' //antes de que empiece el ciclo datos este vacio
    while (i<arreglo.length){ // length para mostrar los elementos que hay en un arreglo

        //empezamos a concatenar los elementos del arreglo a las  tabla 
        document.getElementById('datos').innerHTML +=`
        
            <tr>
                <td> ${arreglo [i]} </td>
                <td> <button onclick='eliminar(${i})'>  eliminar </button> </td>
            </tr>    
        `

        i++;
    }

}

function eliminar (posicion){
    arreglo.splice(posicion,1)
    imprimir();
}

function Agregar(){
    let otro = prompt('Ingrese nombre animal');
    arreglo.push(otro);
    imprimir();
}


imprimir();