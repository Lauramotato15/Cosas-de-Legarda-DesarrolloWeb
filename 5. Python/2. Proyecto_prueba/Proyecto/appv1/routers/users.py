from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from appv1.crud.users import create_user_sql
from appv1.schemas.user import UserCreate
from db.database import get_db
from sqlalchemy import text


router = APIRouter()

@router.post("/create")
async def insert_user(user: UserCreate, db: Session = Depends(get_db)):
    respuesta = create_user_sql(db, user)

    if respuesta:
        return {"mensaje":"Usuario ingresado exitosamente"}
    else:
        return  {"mensaje":"No se ha registrado usuario"}