from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from appv1.crud import users
from appv1.crud.users import create_user_sql, get_all_by_users, get_user_by_email
from appv1.schemas.user import UserCreate, UserResponse
from db.database import get_db
from sqlalchemy import text


router_user = APIRouter()

@router_user.post("/create")
async def insert_user(user: UserCreate, db: Session = Depends(get_db)):

    respuesta = create_user_sql(db, user)

    if respuesta:
        return {"mensaje":"Usuario ingresado exitosamente"}
    
@router_user.get("/get-user-by-email",response_model= UserResponse)
async def read_user_by_email(email: str, db: Session = Depends(get_db)):

    usuario = get_user_by_email(db, email)
    if usuario is None: 
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    return usuario

@router_user.get("/get-all",response_model= List[UserResponse])
async def read_user_by_statud(db: Session = Depends(get_db)):

    usuarios = get_all_by_users(db)
    if usuarios is None: 
        raise HTTPException(status_code=404, detail="No hay usuarios")
    return usuarios


    