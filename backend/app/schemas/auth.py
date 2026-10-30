from pydantic import BaseModel
from pydantic import Field
class LoginRequest(BaseModel):
    username: str
    password: str

class TokenResponse(BaseModel):
    access_token: str
    token_type: str="bearer"

class CurrentUser(BaseModel):
    staff_uid: int
    staff_name: str
    role: str

class ChangePasswordRequest(BaseModel):
    current_password: str
    new_password: str = Field(min_length=8)
    