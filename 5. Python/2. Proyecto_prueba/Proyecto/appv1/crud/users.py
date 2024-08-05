
# Crear un usuario
from sqlalchemy import text
from sqlalchemy.orm import Session
from appv1.schemas.user import UserCreate
from core.security import get_hashed_password
from core.utils import generate_user_id

def create_user_sql(db: Session, user: UserCreate):
    sql_query = text(
        "INSERT INTO users (user_id, full_name, mail, passhash, user_role) "
        "VALUES (:user_id, :full_name, :mail, :passhash, :user_role)"
    )
    params = {
        "user_id": generate_user_id(0),
        "full_name": user.full_name,
        "mail": user.mail,
        "passhash": get_hashed_password(user.passhash),
        "user_role": user.user_role,
    }
    db.execute(sql_query, params)
    db.commit()
    return True  # Retorna True si la inserción fue exitosa