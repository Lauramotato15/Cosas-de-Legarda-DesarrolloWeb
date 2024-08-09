from typing import Annotated, List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from appv1.crud import users
from appv1.crud.users import create_user_sql, delete_user, get_all_by_users, get_all_users_paginated, get_user_by_email, update_user
from appv1.schemas.user import PaginatedUsersResponse, UserCreate, UserResponse, UserUpdate
from core.security import create_access_token, verify_password
from db.database import get_db
from sqlalchemy import text
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm


router_user = APIRouter()

def authenticate_user(username: str, password: str,db: Session = Depends(get_db)):
    user = get_user_by_email(db, username)
    if not user:
        return False

    if not verify_password(password, user.passhash):
        return False

    return user

@router_user.get("/login/",response_model= dict)
async def access(email: str, password: str, db: Session = Depends(get_db)):

    usuario = get_user_by_email(db, email)
    print(usuario)
    if usuario is None: 
        raise HTTPException(status_code=404, detail="Usuario o contraseña no valida")
    if not verify_password(password, usuario.passhash):
        raise HTTPException(status_code=404, detail="Usuario o contraseña no valida")
    
    data = {"sub": usuario.user_id, "rol": usuario.user_role}
    tokens = create_access_token(data)
    return {"token": tokens}  


@router_user.post("/token")
async def login_for_access_token(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()],
    db: Session = Depends(get_db)
):
    user = authenticate_user(form_data.username, form_data.password, db)
    if not user:
        raise HTTPException(
            status_code=401,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = create_access_token(
        data={"sub": user.user_id, "rol": user.user_role}
    )
    return {"access_token": access_token, "token_type": "bearer"}