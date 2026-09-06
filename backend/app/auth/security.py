from datetime import datetime, timedelta, timezone
import jwt
from pwdlib import PasswordHash
from config import( JWT_SECRET_KEY,JWT_ALGORITHM,JWT_ACCESS_TOKEN_EXPIRE_HOURS)

pwd_context=PasswordHash.recommended()
def hash_password(password: str)->str:
    return pwd_context.hash(password)
def verify_password(password: str,password_hash: str)->bool:
    return pwd_context.verify(password,password_hash)

def create_access_token(data: dict)->str:
    payload =data.copy()
    expire= datetime.now(timezone.utc)+ timedelta(hours=JWT_ACCESS_TOKEN_EXPIRE_HOURS)
    payload.update({"exp":expire})
    return jwt.encode(payload,JWT_SECRET_KEY,algorithm=JWT_ALGORITHM)

def decode_access_token(token: str)->dict:
    return jwt.decode(
        token,
        JWT_SECRET_KEY,
        algorithms=[JWT_ALGORITHM]
    )