let turno = 'X';
let uno = 'a';
let dos = 'b';
let tres = 'c';
let cuatro = 'd';
let cinco = 'e';
let seis = 'f';
let siete = 'j';
let ocho = 'h';
let nueve = 'i';




function jugar(num) {

    document.getElementById(num).innerHTML = + turno;

    verificar(num, turno);

    if (turno == 'X') {
        turno = 'O';

    } else {
        turno = 'X';
    }
}

function verificar(num, turnito) {

    switch (num) {
        case '1':
            uno = turnito;
            break;

        case '2':
            dos = turnito;
            break;

        case '3':
            tres = turnito;
            break;

        case '4':
            cuatro = turnito;
            break;

        case '5':
            cinco = turnito;
            break;

        case '6':
            seis = turnito;
            break;

        case '7':
            siete = turnito;
            break;

        case '8':
            ocho = turnito;
            break;

        case '9':
            nueve = turnito;

        default :
        alert("No valido");
    }

    console.log(uno);
    console.log(dos);
    console.log(tres);
    console.log(cuatro);
    console.log(cinco);
    console.log(seis);
    console.log(siete);
    console.log(ocho);
    console.log(nueve);
}

function quien_gano(){
    if (uno==dos && uno==tres){
        alert('Felicitaciones, Ganaste!');
    }

    if (cuatro==cinco && cuatro==seis){
        alert('Felicitaciones, Ganaste!');
    }

    if (siete==ocho && siete==nueve){
        alert('Felicitaciones, Ganaste!');
    }

    if (uno==cuatro && uno==siete){
        alert('Felicitaciones, Ganaste!');
    }

    if (dos==cinco&& dos==ocho){
        alert('Felicitaciones, Ganaste!');
    }

    if (tres==seis && dos==nueve){
        alert('Felicitaciones, Ganaste!');
    }

    if (tres==cinco && uno==nueve){
        alert('Felicitaciones, Ganaste!');
    }

    if (tres==cinco && tres==siete){
        alert('Felicitaciones, Ganaste!');
    }
    
}