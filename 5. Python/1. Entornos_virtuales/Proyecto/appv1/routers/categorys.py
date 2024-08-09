
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from appv1.crud.categorys import create_category_sql, get_category_by_id, get_categorys
from appv1.schemas.category import CategoryCreate, CategoryResponse
from db.database import get_db


router_category = APIRouter()

@router_category.post("/create")
async def insert_category(category: CategoryCreate, db: Session = Depends(get_db)):

    respuesta = create_category_sql(db, category)

    if respuesta:
        return {"mensaje":"Categoria ingresado exitosamente"}
    
@router_category.get("/get-category-by-id",response_model= CategoryResponse)
async def read_category_by_id(id: int, db: Session = Depends(get_db)):

    categoria= get_category_by_id(db,id)
    if categoria is None: 
        raise HTTPException(status_code=404, detail="Categoria no encontrado")
    return categoria

@router_category.get("/get-all-categorys",response_model= List[CategoryResponse])
async def read_categorys(db: Session = Depends(get_db)):

    categorias= get_categorys(db)
    if categorias is None: 
        raise HTTPException(status_code=404, detail="No hay categorias disponibles")
    return categorias