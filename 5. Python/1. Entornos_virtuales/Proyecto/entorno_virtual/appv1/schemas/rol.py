from typing import Annotated
from pydantic import BaseModel, StringConstraints

class RolCreate(BaseModel):
    rol_name: Annotated[str,StringConstraints(max_length=15)]
    
