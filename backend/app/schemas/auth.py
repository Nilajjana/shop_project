from pydantic import BaseModel
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