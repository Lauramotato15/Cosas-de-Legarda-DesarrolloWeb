from fastapi import FastAPI
from appv1.routers import users
from appv1.schemas.user import UserCreate
from db.database import test_db_connection
from core.security import get_hashed_password, verify_password, create_access_token

app = FastAPI()
app.title = "Mi primera API"
app.version = "2.0.0"

app.include_router(users.router)

@app.on_event("startup")
def on_startup():
    test_db_connection()


@app.get("/")
def read_root():
    return {"mensaje":"hello word"}

