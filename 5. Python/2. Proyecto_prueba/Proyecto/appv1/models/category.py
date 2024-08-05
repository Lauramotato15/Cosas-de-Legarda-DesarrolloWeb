from pickle import BININT
from sqlalchemy import SMALLINT, Column, String, Boolean
from sqlalchemy.orm import relationship
from models.base_class import Base
from datetime import datetime

class Category(Base):
    __tablename__ = 'category'
    category_id = Column(SMALLINT(3),autoincrement=True , primary_key=True)
    category_name = Column(String(50))
    category_description = Column(String(120))
    category_status = Column(Boolean(1), default=True)
    