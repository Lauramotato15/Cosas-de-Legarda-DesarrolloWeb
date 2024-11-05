let citas = [
    ['Cena romántica en casa', ' Con velas y música'],
    ['Visita a un parque local', ' Disfrutar de un paseo por un parque cercano'],
    ['Picnic en un lugar tranquilo', ' Lleva bocadillos y una manta para un picnic'],
    ['Noche de películas en casa', ' Preparar palomitas de maíz y vean películas'],
    ['Visita a un museo gratuito', ' Explorar el arte y la historia en un museo gratuito'],
    ['Noche de juegos de mesa', ' Jugar nuestros juegos favoritos en casa'],
    ['Caminata en la naturaleza', ' Descubrir rutas de senderismo locales'],
    ['Visita a una feria local', ' Disfrutar de juegos y comida en la feria'],
    ['Noche de observación de estrellas', ' Mirar las estrellas'],
    ['Visita a un mercado de agricultores', ' Probar productos locales y frescos'],
    ['Noche de karaoke en casa', ' Cantar canciones favoritas juntos'],
    ['Noche de cocina juntos', ' Preparar una receta nueva'],
    ['Visita a un jardín botánico', ' Disfrutar de la belleza de las plantas'],
    ['Clase de cocina económica', ' Aprender a cocinar platos económicos'],
    ['Noche de música en vivo', ' Disfrutar de música en un bar local'],
    ['Visitan un lugar con verde', ' Explorar la naturaleza en su esplendor'],
    ['Noche de lectura de poesía', ' Leer y compartir poesía juntos'],
    ['Visita a un mercado de pulgas', ' Buscar tesoros'],
    ['Clase de meditación en pareja', ' Practicar la meditación juntos'],
    ['Noche de fotografía', ' Salir a tomar fotos juntos'],
    ['Cita de spa en casa', ' Disfrutar de masajes y cuidado de la piel'],
    ['Noche de juegos de palabras', ' Jugar a juegos de palabras juntos'],
    ['Visita a una cascada', ' Explorar una cascada cercana'],
    ['Clase de cocina saludable', ' Aprender a cocinar de manera saludable'],
    ['Noche de pintura en casa', ' Pintar juntos en lienzo'],
    ['Cita de fondue en casa', ' Derrite queso o chocolate para fondue'],
    ['Tardecita de voleibol', ' Jugar voleibol en la playa'],
    ['Clase de cerámica en pareja', ' Haz cerámica juntos'],
    ['Noche de bolos', ' Disfrutar de un juego de bolos'],
    ['Cita de postres en casa', ' Preparar postres caseros'],
    ['Visita a una granja de animales', ' Conocer a los animales de la granja'],
    ['Noche de cocina internacional', ' Cocina platos internacionales'],
    ['Cita de jardinería', ' Planta flores o hierbas juntos'],
    ['Visita a una tienda de antigüedades', ' Busca tesoros antiguos'],
    ['Cita de jardinería', ' Plantar flores o hierbas juntos'],
    ['Visita a una tienda de antigüedades', ' Buscar tesoros antiguos'],
    ['Noche de cocina de pizza', ' Prepara pizza casera desde cero'],
    ['Noche de construcción de un rompecabezas', ' Armar un rompecabezas juntos'],
    ['Cita de picnic nocturno', ' Hacer un picnic bajo las estrellas'],
    ['Noche de maratón de películas clásicas', ' Ver películas clásicas'],
    ['Cita de pintura de rocas', ' Pintar rocas y déjarlas en lugares especiales'],
    ['Noche de lectura de cuentos de misterio', ' Sumérgirnos en historias misteriosas'],
    ['Cita de baile bajo las estrellas', ' Bailar al aire libre en una noche despejada'],
    ['Cita de experimentos científicos en casa', ' Realizar experimentos divertidos'],
    ['Cita de yoga en pareja', ' Practicar yoga juntos en casa con tutoriales'],
    ['Cita de dibujo o pintura al aire libre', ' Llevar suministros y crea arte al aire libre'],
    ['Visita a una heladería local', ' Disfrutar de helados caseros'],
    ['Cita de senderismo en la naturaleza', ' Salir a caminar por senderos naturales'],
    ['Cita de construcción fuerte de mantas', ' Construir una casita de cobijas en casa'],
    ['Noche de sesión de fotos en pareja', ' Toma fotos creativas juntos']
];


function noguardar() {

    alert("Te lo pierdes, te arrepentiras y me las pagaras...");
}


function imprimir() {

    let fila = Math.floor(Math.random() * citas.length);
    let indice = citas[fila];

    const nodotitulo = document.createTextNode("Cita con mi amor")
    const nodoCita = document.createTextNode(indice);
    const nodoQuiero = document.createTextNode("Si");
    const nodoNoQuiero = document.createTextNode("No");

    const titulo = document.createElement("h5");
    titulo.classList.add("card-title")
    titulo.appendChild(nodotitulo);

    const parrafo = document.createElement("p");
    parrafo.classList.add("card-text");
    parrafo.appendChild(nodoCita);

    const botonSi = document.createElement("button");
    botonSi.classList.add("btn", "btn-primary");
    botonSi.appendChild(nodoQuiero);
    botonSi.addEventListener("click", function(){
        Felicitaciones(indice);
    })

    const sepa = document.createTextNode(" "); 

    const botonNo = document.createElement("button");
    botonNo.classList.add("btn", "btn-primary");
    botonNo.appendChild(nodoNoQuiero);
    botonNo.addEventListener("click", function(){
        eliminar(indice);
    })

    const cardBody = document.createElement("div");
    cardBody.classList.add("card-body");
    cardBody.appendChild(titulo);
    cardBody.appendChild(parrafo);
    cardBody.appendChild(botonSi);
    cardBody.appendChild(sepa);
    cardBody.appendChild(botonNo);

    const card1 = document.createElement("div");
    card1.classList.add("lindo");
    card1.appendChild(cardBody);

    const dato = document.getElementById("datos").appendChild(card1);
}

function Felicitaciones (){
    alert("TE AMO CON TODO MI CORAZÓN, LINDO MIO");
}

function eliminar (indice){
    citas.splice(indice,1);
    
    const contenedor = document.getElementById("datos");
    contenedor.innerHTML = "";
    imprimir();
}
