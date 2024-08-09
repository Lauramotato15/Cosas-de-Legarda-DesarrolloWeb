from dotenv import load_dotenv #Modulo Para cargar las variables de entorno que hay en el archivo .env 
#en nuestro proyecto(aplicación)
import os #Se utiliza para manejar directorios, rutas y nombre de archivos. 

# Obtener la ruta al archivo .env
dotenv_path = os.path.join(os.path.dirname(__file__), '..', '.env')#_file_ hace referencia a la ruta completa del archivo en el que estamos parados
#  

# Cargar variables de entorno desde el archivo .env
load_dotenv(dotenv_path)

class Settings: #Clase de configuraciones del proyecto
    PROJECT_NAME: str = "GASTOS-INGRESOS" #Constantes con datos básicos del proyecto...
    PROJECT_VERSION: str = "0.0.1"
    PROJECT_DESCRIPTION: str = "Aplicación para administrar los gastos e ingresos de varios usuarios"

    DB_HOST: str = os.getenv("DB_HOST") #Estamos tomando el valor que tiene la variable de entorno "DB_HOST" en .env y almacenandolo en variables
    DB_USER: str = os.getenv("DB_USER") #Los mismo con este resto 
    DB_PASSWORD: str = os.getenv("DB_PASSWORD")
    DB_NAME: str = os.getenv("DB_NAME")
    DB_PORT: str = os.getenv("DB_PORT", 3306)  # default mysql port is 3306, eso ya depende del motor
    
    DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    #Con esta linea de codigo se hace la conexión a la base de datos, en sqlalchemy, quedaria algo asi: 
    #mysql+pymysql://mi_usuario:mi_contraseña@localhost:3306/mi_base_de_datos

    SECRET_KEY: str = os.getenv("SECRET_KEY") 
    
    TOKEN_EXPIRE_MIN = 30  # in mins Definimos el tiempo de sesión que tendra el usuario 
    ALGORITHM: str = os.getenv("ALGORITHM")

settings = Settings() #Creamos una instancia de ese objeto