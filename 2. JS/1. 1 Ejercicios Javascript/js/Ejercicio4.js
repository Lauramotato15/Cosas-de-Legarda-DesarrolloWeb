function compra() {
    let iva = 0.16;
    let producto = 5000;
    let precioiva;
    let cantidades = [];
    let descuento = 0;
    valor = 10;

    alert('Por compras mayores a $230.000 Se hace descuento del 10%');
    let cantidad = parseFloat(prompt('ingrese cantidades que desea del producto'));
    cantidades.push(cantidad);

    for (let i = 0; i < cantidad; i++) {
        if (cantidad > 0 && cantidad < 46) {
            precioiva = (producto * cantidades) + iva;
            document.getElementById("total_pagariva").innerHTML = " " + precioiva;
            document.getElementById("Descuento").innerHTML = "Valor descuento: % " + descuento;

        } else if (cantidad > 46) {
            precioiva = (producto * cantidades) + iva;
            descuento = precioiva * 10 / 100;
            precioiva = precioiva - descuento;

            document.getElementById("total_pagariva").innerHTML = " " + precioiva;
            document.getElementById("Descuento").innerHTML = " " + descuento;
        }
    }

    document.getElementById("Cantidad").innerHTML = "JABONES:  " + cantidad;

}

