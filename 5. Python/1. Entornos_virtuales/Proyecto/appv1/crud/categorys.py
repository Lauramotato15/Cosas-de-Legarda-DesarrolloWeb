from fastapi import HTTPException
from sqlalchemy.exc import SQLAlchemyError, IntegrityError
from sqlalchemy import text
from sqlalchemy.orm import Session
from appv1.schemas.category import CategoryCreate

def create_category_sql(db: Session, category: CategoryCreate):
    try:
        sql_query = text(
        "INSERT INTO category (category_name, category_description, category_status) "
        "VALUES (:name, :description, :status)"
        )
        params = {
            "name": category.category_name,
            "description": category.category_description,
            "status": True,
        }
        db.execute(sql_query, params)
        db.commit()
        return True  # Retorna True si la inserción fue exitosa
    except IntegrityError as e:
        db.rollback() 
        print(f"Error al crear categoria: {e}")
        return {f"Error al insertar categoria {e}"}
    
def get_category_by_id(db: Session, id: int):
    try:
        sql = text("SELECT * FROM category WHERE category_id = :id")
        result = db.execute(sql, {"id": id}).fetchone()
        return result
    except SQLAlchemyError as e: 
        print(f"Error al buscar categoria por id: {id}")
        raise HTTPException(status_code=500, detail="Error Al consultar por id")
    
def get_categorys(db: Session):
    try:
        sql = text("SELECT * FROM category")
        result = db.execute(sql).fetchall()
        return result
    except SQLAlchemyError as e: 
        print(f"Error al buscar categorias: {e}")
        raise HTTPException(status_code=500, detail="Error Al consultar las categorias")