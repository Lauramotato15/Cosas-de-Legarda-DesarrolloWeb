from fastapi import FastAPI 
app = FastAPI() #Guarda la configuracion y logica de mi api, en esta variable se guarda el servicio es decir la API

#Le agregamos las rutas a nuestro servicio. 
sumar = 1 + 2
@app.get("/")  #@funcionDecoradora -> Cuando ingresen a la raiz se ejecuta la funcion de la siguiente linea. 
async def suma(): #funcion decorada. 
    return {'resultado': sumar, 'operacion': 'sumar'}

@app.get("/hola") #Las peticiones pueden retornar int,string,object, etc.. 
async def saludo(): 
    dic = {"uno":1, "dos":2, "tres":3, "cuatro":4}
    list = [1,3,5,7,9]
    return 2

@app.get("/hola2/{item_nombre}") #Las peticiones por el método get pueden recibir parametros, que luego se le pasan a la funcion que va a decorar, teniendo en cuenta que debe ser el mismo nombre para que reconozca este parametro. 
async def saludo(item_nombre:int): #Podemos definir el tipo de dato del parametro, cuando se lo enviemos a la función.  
    return {"saludo": f"hola soy {item_nombre}"}

@app.get("/users/me")
async def read_user_me():
 return {"Users.me": "soy user me"}

@app.get("/users/{user_id}")
async def read_user(user_id: str):
 return {"user_id": user_id}

#Estamos creando un enum con una clase, en donde esa clase hereda de ENUM y de STR para especificarle 
# que va a ser un ENUM de string con esas opciones. 
from enum import Enum
class ModelName(str, Enum):
 alexnet = "alexnet"
 resnet = "resnet"
 lenet = "lenet"

@app.get("/models/{model_name}")
async def get_model(model_name: ModelName):
    if model_name is ModelName.alexnet: #Primera manera de validar que el parametro que pasaron este entre las opciones del ENUM 
        return {"model_name": model_name, "message": "Deep Learning FTW!"}
    if model_name.value == "lenet": # Segunda manera
        return {"model_name": model_name, "message": "LeCNN all the images"}
    if ModelName.alexnet.value == model_name.value: #Tercera manera 
       return {"model_name": model_name, "message": "LeCNN all the images"} 
    
    return {"model_name": model_name, "message": "Have some residuals"}


@app.get("/files/{file_path:path}") #En un parametro de una petición también se pueden enviar paths(rutas,url..)pero debemos ponerle la anoticion de tipo para que sepa que recibe un path y que debe coincidir con algun path. 
async def read_file(file_path: str):
 return {"file_path": file_path}


fake_items_db = [{"item_name": "Foo"}, {"item_name": "Bar"}, {"item_name": "Baz"}]
@app.get("/items/")
async def read_item(skip: int = 0, limit: int = 10): #por el path podemos recibir parametros opcionales,
    # que se envian por el path?skip=12, si no se envia toma el valor por defecto. 
 return fake_items_db[skip : skip + limit]#En esta linea de codigo estamos definiendo que la lista inicia desde el valor de skip y terminara en el valor que tenga limit.

from typing import Union
@app.get("/items/{item_id}")
async def read_item(item_id: int, q: Union[str, None] = None): #En este caso el parametro opcional 'q', puede ser string o none, 
    #esa es una manera de definir, pero podemos hacerla de esta manera que es mas corta (q: str|None = None=)
    if q:
        return {"item_id": item_id, "q": q}
    return {"item_id": item_id}


@app.get("/foo/{item_id}")
async def read_item(item_id: str, q: Union[str, None] = None, short: bool = False):
    item = {"item_id": item_id}
    if q:
        item.update({"q": q})
    if short:
        item.update({"description": short}
    )
    return item


from pydantic import BaseModel #BaseModel es como un request en laravel, proviene de la libreria pydanthic 
#Pydantic es una biblioteca que se utiliza para hacer validacion, modelos de datos y conversiones de datos, 
#siempre y cuando cumpla con las validaciones.  
class Item(BaseModel): #Definimos una clase llamada item que hereda de BaseModel. 
 name: str #Definimos los campos que van a ser requeridos, los campos que tengan valores por defecto no son requeridos.Usa None para hacerlo opcional.
 description: str | None = None
 price: float
 tax: float | None = None

@app.post("/items/")
async def create_item(item: Item): #La funcion de crear, debe recibir por parametros un objeto de tipo Item, debe ser completo. 
 return item

@app.post("/items/")
async def create_item(item: Item):
 item_dict = item.model_dump()
 if item.tax:
    price_with_tax = item.price + item.tax
    item_dict.update({"price_with_tax": price_with_tax})
    return item_dict
