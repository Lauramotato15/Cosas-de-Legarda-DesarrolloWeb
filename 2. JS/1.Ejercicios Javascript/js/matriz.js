let matriz=[['a','b','c'], ['d','e','f'], ['g','h','i']];

let turno='X';

function jugar (row,col,id){
    
    matriz [row][col]=turno;
    verificar_ganador(turno);

    document.getElementById(id).innerHTML=turno;

    if(turno=='X'){
        turno='O';

    }else{
        turno='X';
    }
}

function verificar_ganador(){
    console.log(matriz)
    if (matriz[0][0]== matriz[0][1] && matriz[0][0]== matriz[0][2]){
        alert("Feliciades hay un ganador "+turno);
    }

    if (matriz[1][0]== matriz[1][1] && matriz[1][0]== matriz[1][2]){
        alert("Feliciades hay un ganador "+turno);
    }

    if (matriz[2][0]== matriz[2][2] && matriz[2][0]== matriz[2][2]){
        alert("Feliciades hay un ganador "+turno);
    }

    if (matriz[0][0]== matriz[1][0] && matriz[0][0]== matriz[2][0]){
        alert("Feliciades hay un ganador "+turno);
    }

    if (matriz[0][1]== matriz[1][1] && matriz[0][1]== matriz[0][1]){
        alert("Feliciades hay un ganador "+turno);
    }

    if (matriz[0][2]== matriz[1][2] && matriz[0][2]== matriz[2][2]){
        alert("Feliciades hay un ganador "+turno);
    }

    if (matriz[0][0]== matriz[1][1] && matriz[0][0]== matriz[2][2]){
        alert("Feliciades hay un ganador "+turno);
    }

    if (matriz[0][2]== matriz[1][1] && matriz[0][2]== matriz[2][0]){
        alert("Feliciades hay un ganador "+turno);
    }


}




