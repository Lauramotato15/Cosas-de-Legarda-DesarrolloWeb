from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from appv1.crud.rols import create_rol_sql, get_rol_by_name, get_rols
from appv1.schemas.rol import  RolCreate
from db.database import get_db


router_rol = APIRouter()

@router_rol.post("/create")
async def insert_rol(rol: RolCreate, db: Session = Depends(get_db)):
    respuesta = create_rol_sql(db, rol)

    if respuesta:
        return {"mensaje":"Rol ingresado exitosamente"}

@router_rol.get("/get-rol-by-name",response_model= RolCreate)
async def read_rols_by_name(name: str, db: Session = Depends(get_db)):

    rol = get_rol_by_name(db, name)
    if rol is None: 
        raise HTTPException(status_code=404, detail="Rol no encontrado")
    return rol

@router_rol.get("/get-all-roles",response_model= List[RolCreate])
async def read_rols(db: Session = Depends(get_db)):

    rol = get_rols(db)
    if rol is None: 
        raise HTTPException(status_code=404, detail="No hay roles disponibles")
    return rol