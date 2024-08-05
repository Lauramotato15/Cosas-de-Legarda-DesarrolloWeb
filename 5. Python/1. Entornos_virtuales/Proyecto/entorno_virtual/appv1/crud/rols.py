# Crear un rol
from fastapi import HTTPException
from sqlalchemy.exc import SQLAlchemyError, IntegrityError
from sqlalchemy import text
from sqlalchemy.orm import Session
from appv1.schemas.rol import RolCreate


def create_rol_sql(db: Session, rol: RolCreate):
    try:
        sql_query = text(
        "INSERT INTO roles (rol_name) "
        "VALUES (:rol_name)"
        )
        params = {
            "rol_name": rol.rol_name
        }
        db.execute(sql_query, params)
        db.commit()
        return True  # Retorna True si la inserción fue exitosa
    except IntegrityError as e:
        db.rollback() 
        print(f"Error al crear rol: {e}")
        raise HTTPException(status_code=500, detail="Error. El rol ya existe")
    
def get_rol_by_name(db: Session, name: str):
    try:
        sql = text("SELECT * FROM roles WHERE rol_name = :name")
        result = db.execute(sql, {"name": name}).fetchone()
        return result
    except SQLAlchemyError as e: 
        print(f"Error al buscar rol especifico: {name}")
        raise HTTPException(status_code=500, detail="Error Al consultar por name")
    
def get_rols(db: Session):
    try:
        sql = text("SELECT * FROM roles")
        result = db.execute(sql).fetchall()
        return result
    except SQLAlchemyError as e: 
        print(f"Error al buscar roles")
        raise HTTPException(status_code=500, detail="Error al consultar roles")
    