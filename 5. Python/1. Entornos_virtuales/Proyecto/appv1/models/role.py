from sqlalchemy import Column, String
from models.base_class import Base

class Role(Base):
    __tablename__ = 'roles'
    role_name = Column(String(15), primary_key=True)