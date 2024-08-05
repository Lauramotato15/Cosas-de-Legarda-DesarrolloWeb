from pickle import BININT, INT
from sqlalchemy import CHAR, DATE, SMALLINT, Column, Float, ForeignKey, String, Boolean, Enum
from sqlalchemy.orm import relationship
from models.base_class import Base
from datetime import datetime
import enum

class TransactionType(enum.Enum):
    revenue = "revenue"
    expenses = "expenses"

class Transaction(Base):
    __tablename__ = 'transactions'
    transactions_id = Column(INT,autoincrement=True , unique=True ,primary_key=True)
    user_id = Column(CHAR(30), ForeignKey('users.user_id'))
    category_id = Column(SMALLINT(3), ForeignKey('category.category_id'))
    amount = Column(Float(10,2))
    t_description = Column(String(120))
    t_type = Column(Enum(TransactionType))
    t_date = Column(DATE)

    user = relationship("User")
    category = relationship("Category")

    