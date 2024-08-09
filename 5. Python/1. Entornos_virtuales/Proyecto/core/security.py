from passlib.context import CryptContext #Passlib es una libreria para la gestion de contraseñas y verificacion, para escriptar de manera segura.
from datetime import datetime, timedelta, timezone #Libreria para fechas, y tiempos
from jose import JWTError, jwt #jwt -> Libreria para gestionar y hacer validaciones del token,
#Como trasmitir la información por medio del formato JSON, información como: rol, user, tipo de token, entre otros. 
#JWTError -> Libreria para gestionar los errores que sucedan con las validiones del token 
from core.config import settings #Importando la clase setting, que contiene las configuraciones

# Configurar hashing de contraseñas
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto") #Objeto para hashear las contraseñas

# Función para generar un hashed_password contraseña encriptada que recibe un string y ñp encripta
def get_hashed_password(password: str):
    return pwd_context.hash(password)

# Función para verificar una contraseña hashada
def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

# Función para crear un token JWT
def create_access_token(data: dict):
    to_encode = data.copy() #Hacemos una copia de ese diccionario
    expire = datetime.now(tz=timezone.utc) + timedelta(minutes=settings.TOKEN_EXPIRE_MIN) #Establecemos el tiempo que durara el token y la fecha
    to_encode.update({"exp": expire}) #Le agregamos a la copia del diccionario un par
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM) #Estamos codificando (firmando) ese token
    return encoded_jwt #Se retorna la información del token, ya cifrada y segura

# Función para verificar si un token JWT es valido
async def verify_token(token: str):
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])#Descodificando el token(leer)
        #y obtener el payload que es como el cuerpo del token(la información en formato JSON)
        user: str = payload.get("sub") # Obtienes el identificador de usuario
        return user
    except jwt.ExpiredSignatureError: # Token ha expirado
        return None
    except JWTError: #Se produce algún otro error 
        return None