
# Crear un usuario
from fastapi import HTTPException
from sqlalchemy import text
from sqlalchemy.orm import Session
from appv1.schemas.user import UserCreate
from core.security import get_hashed_password
from core.utils import generate_user_id
from sqlalchemy.exc import SQLAlchemyError, IntegrityError

def create_user_sql(db: Session, user: UserCreate):

    try:
        sql_query = text(
        "INSERT INTO users (user_id, full_name, mail, passhash, user_role) "
        "VALUES (:user_id, :full_name, :mail, :passhash, :user_role)"
        )
        params = {
            "user_id": generate_user_id(30),
            "full_name": user.full_name,
            "mail": user.mail,
            "passhash": get_hashed_password(user.passhash),
            "user_role": user.user_role,
        }
        db.execute(sql_query, params)
        db.commit()
        return True  # Retorna True si la inserción fue exitosa
    except IntegrityError as e:
        db.rollback()  # Revertir la transacción en caso de error de integridad (llave foránea)
        print(f"Error al crear usuario: {e}")
        if 'Duplicate entry' in str(e.orig):
            if 'PRIMARY' in str(e.orig):
                raise HTTPException(status_code=400, detail="Error. El ID de usuario ya está en uso")
            if 'for key \'mail\'' in str(e.orig):
                raise HTTPException(status_code=400, detail="Error. El email ya está registrado")
        else:
            raise HTTPException(status_code=400, detail="Error. No hay Integridad de datos al crear usuario")
    except SQLAlchemyError as e:
        db.rollback()  # Revertir la transacción en caso de error de integridad (llave foránea)
        print(f"Error al crear usuario: {e}")
        print("Error ", e)
        raise HTTPException(status_code=500, detail="Error. No hay Integridad de datos")

# Consultar un usuario por su email
def get_user_by_email(db: Session, mail: str):
    try:
        sql = text("SELECT * FROM users WHERE mail = :mail")
        result = db.execute(sql, {"mail": mail}).fetchone()
        return result
    except SQLAlchemyError as e: 
        print(f"Error al buscar usuario por email: {mail}")
        raise HTTPException(status_code=500, detail="Error Al consultar por email")
    
# Consultar todos los usuarios activos
def get_all_by_users(db: Session):
    try:
        sql = text("SELECT * FROM users WHERE user_status = true")
        result = db.execute(sql).fetchall()
        return result
    except SQLAlchemyError as e: 
        print(f"Error al buscar usuarios: {e}")
        raise HTTPException(status_code=500, detail="Error Al consultar todos los usuarios")
    


    