from fastapi import FastAPI
from appv1.routers import categorys, rols, users
from db.database import test_db_connection
from appv1.routers import login 

app = FastAPI()
app.include_router(users.router_user, prefix="/users", tags=["Usuarios"])
app.include_router(rols.router_rol, prefix="/rols", tags=["Roles"])
app.include_router(categorys.router_category, prefix="/category", tags=["Categorias"])
app.include_router(login.router_user, prefix="/access", tags=["Access_token"])
@app.on_event("startup")
def on_startup():
    test_db_connection()


