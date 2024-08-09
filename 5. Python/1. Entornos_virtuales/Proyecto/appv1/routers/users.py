from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from appv1.crud import users
from appv1.crud.users import create_user_sql, delete_user, get_all_by_users, get_all_users_paginated, get_user_by_email, update_user
from appv1.schemas.user import PaginatedUsersResponse, UserCreate, UserResponse, UserUpdate
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


# Endpoint para actualizar un usuario
@router_user.put("/update/", response_model=dict)
def update_user_by_id(user_id: str, user: UserUpdate, db: Session = Depends(get_db)): 
    usuario_editado = update_user(db, user_id, user)
 
    if usuario_editado:
        return {"mensaje": "Registro actualizado con éxito" }
 
    
# usuarios paginados
@router_user.get("/users-by-page/", response_model=PaginatedUsersResponse)
def get_all_users_by_page(page: int = 1, page_size: int = 10, db: Session = Depends(get_db)):
    
    users, total_pages = get_all_users_paginated(db, page, page_size)

    return {
        "users": users,
        "total_pages": total_pages,
        "current_page": page,
        "page_size": page_size
    }

@router_user.delete("/delete/{user_id}", response_model=dict)
def delete_user_by_id(user_id: str, db: Session = Depends(get_db)):
    result = delete_user(db, user_id)
    if result is None:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    
    if result:
        return {"mensaje": "Usuario eliminado con éxito"}
    

