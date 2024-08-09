import secrets #Libreria para generar datos aleatorios de forma segura
import string #Libreria que contiene constantes y funciones que son utiles para cadenas de texto

# Función para generar un ID de usuario aleatorio
def generate_user_id(length=30): 
    # Caracteres posibles para el ID aleatorio
    characters = string.ascii_letters + string.digits #Cadena de texto con letras(a->z) y numeros(0->9)

    # Genera un ID aleatorio de la longitud deseada
    random_id = ''.join(secrets.choice(characters) for _ in range(length)) #En cada iteracion del bucle se selecciona
    #un caracter de manera ramdom
    return random_id