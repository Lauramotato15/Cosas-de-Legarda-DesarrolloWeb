let uno =[a,b,c];
let dos = [d,f,g];
let tres=[h,i,j];

let turno='X';

function jugar (num){
    document.getElementById(num).innerHTML= turno;

    almacenar (num,turno);
    
    if (turno== 'x'){
        turno=='O';
    }else{
        turno=='X';
    }
}

function almacenar(numerito, turnito){
    if (numerito=='1'){
        uno[0]=turnito;
    }

    if (numerito=='2'){
        uno[1]=turnito;
    }

    if (numerito=='3'){
        uno[2]=turnito;
    }

    if (numerito=='4'){
        dos[0]=turnito;
    }

    if (numerito=='5'){
        dos[1]=turnito;
    }

    if (numerito=='6'){
        dos[2]=turnito;
    }

    if (numerito=='7'){
        tres[0]=turnito;
    }

    if (numerito=='8'){
        tres[1]=turnito;
    }

    if (numerito=='9'){
        tres[2]=turnito;
    }

    quien_gano()
}
if (uno[0]==uno && uno[0]== uno[2])

function quien_gano (){
    if (uno [0]==uno[1] && uno[0]==uno[2]){
        alert('Felicitaciones, Ganaste!');
    }

    if (dos[0]==dos[1] && dos[0]==dos[2]){
        alert('Felicitaciones, Ganaste!');
    }

    if (tres[0]==tres[1] && tres[0]==tres[2]){
        alert('Felicitaciones, Ganaste!');
    }

    if (uno[0]== dos[0] && uno==tres[0]){
        alert('Felicitaciones, Ganaste!');
    }

    if (uno[1]==dos[1] && uno [1] == tres[1]){
        alert('Felicitaciones, Ganaste!');
    }

    if (uno[2]==dos[2] && uno[2]==tres[2]){
        alert('Felicitaciones, Ganaste!');
    }

    if (tres[0]==dos[1] && tres[0]==uno[2]){
        alert('Felicitaciones, Ganaste!');
    }

    if (uno[0]==dos[1] && uno[0]==tres[2]){
        alert('Felicitaciones, Ganaste!');
    }
    
}