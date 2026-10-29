from typing import Literal, Optional
from pydantic import BaseModel, ConfigDict, Field

class StaffCreate(BaseModel):
    model_config= ConfigDict(str_strip_whiltespace=True)
    staff_name: str=Field(min_length=4,max_length=50)
    username: str=Field(min_length=3,max_length=50)
    password: str=Field(min_length=8)
    role: Literal["manager", "salesperson"]

class StaffUpdate(BaseModel):
    model_config=ConfigDict(str_strip_whitespace=True)

    staff_name: Optional[str]=Field(default=None,min_length=1,max_length=100)
    role: Optional[Literal["manager", "salesperson"]] = None
    is_active: Optional[bool] = None

class ResetPassword(BaseModel):
    new_password: str = Field(min_length=8)

class StaffOut(BaseModel):
        staff_uid:int
        staff_name:str
        username:Optional[str]
        role: str
        is_active: bool