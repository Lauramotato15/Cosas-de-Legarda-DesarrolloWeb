const horas = 28000;
let i=0;
let total=0;
let totalhoras=0;


let cantidadtra= parseInt(prompt('Ingrese la cantidad de trabajadores'));

while (i<cantidadtra){

    let nombretra= prompt('Ingrese nombre trabajador');

    let horatra= parseInt (prompt('ingrese horas trabajadas'));

    let quincena = horatra * horas;

    totalhoras = totalhoras + horatra;
    total = total + quincena;




    document.getElementById('datos').innerHTML+=` 
        <tr> 
            <td class='text-center'>${nombretra}</td>          
            <td class='text-center'>${horatra}</td>
            <td class='text-center'>${quincena}</td>
        </tr>
    
    `
    //interpolación, comillas cadenas de plantilla 

    i++;
}

document.getElementById('total').innerHTML=total;
document.getElementById('totalhoras').innerHTML=totalhoras;

