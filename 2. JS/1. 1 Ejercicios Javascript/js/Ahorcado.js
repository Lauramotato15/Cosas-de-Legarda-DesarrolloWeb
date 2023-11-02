let palabra = ["l", "a", "u", "r", "a", "l", "i", "n", "d", "a"];
let aciertos = [];
let total_aciertos = 0;
let errores=0;

for (let i = 0; i < palabra.length; i++) {
    aciertos[i] = "*";
}

function imprimir() {
    document.getElementById("letras").innerHTML = ""
    for (let i = 0; i < aciertos.length; i++) {
        document.getElementById("letras").innerHTML += `<div class= "letra"> ${aciertos[i]}</div>`;
    }
}

imprimir();

function validar(){
    let letra = prompt("ingrese letra");
    if (letra && letra.length == 1) {
        let encuentra=false;
        for (let i = 0; i < palabra.length; i++) {
            if (letra == palabra[i] && aciertos[i]!=letra) {
                aciertos[i] = letra;
                total_aciertos++;
                encuentra=true;
                imprimir();
            }
        }

        if(encuentra==false){
            errores++;
            mostrar_muñequito();
        }

    } else {
        alert("Por favor, ingresa una sola letra")
    }

    if(errores==7){
        alert("Perdiste")
    }

    if(total_aciertos==palabra.length){
        alert("Ganaste!")
    }
}

function mostrar_muñequito(){
    let imagen= document.getElementById("ahorcado");
    if (errores==1){
        imagen.setAttribute("src","img/Ahorxado/2.png");
    }
    if (errores==2){
        imagen.setAttribute("src","img/Ahorxado/3.png");
    }
    if (errores==3){
        imagen.setAttribute("src","img/Ahorxado/4.png");
    }
    if (errores==4){
        imagen.setAttribute("src","img/Ahorxado/5.png");
    }
    if (errores==5){
        imagen.setAttribute("src","img/Ahorxado/6.png");
    }
    if (errores==6){
        imagen.setAttribute("src","img/Ahorxado/7.png");
    }
    if (errores==7){
        imagen.setAttribute("src","img/Ahorxado/8.png");
    }
}
