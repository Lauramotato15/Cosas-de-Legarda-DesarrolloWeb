from typing import Annotated
from pydantic import BaseModel, EmailStr, StringConstraints
from datetime import datetime

class UserBase(BaseModel):
    full_name: Annotated[str,StringConstraints(max_length=80)]
    mail: EmailStr
    user_role: Annotated[str,StringConstraints(max_length=15)]

class UserCreate(UserBase):
    passhash: Annotated[str,StringConstraints(max_length=30)]
    
class UserResponse(UserBase):
    user_id: str
    user_status: bool = True
    created_at: datetime
    updated_at: datetime