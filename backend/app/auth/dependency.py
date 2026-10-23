import jwt 
from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer
from sqlalchemy import text
from database import get_db
from auth.security import decode_access_token
bearer = HTTPBearer()
def get_current_user(creds=Depends(bearer), db=Depends(get_db)):
    try:
        payload = decode_access_token(creds.cedentials)
        uid = int(payload["sub"])
    except (jwt.PyJWTError, KeyError,ValueError):
        raise HTTPException(401,"Invalid or epired token")
    row= db.execute(
        text("Select staff_uid,staff_name, role FROM staff"
             "WHERE staff_uid=:i and is_active"),
             {"i": uid},
    ).mappings().first()
    if row is None:
        raise HTTPException(401, "User not found or inactive")
    return dict(row)
def require_role(*roles):
    def checker(user=Depends(get_current_user)):
        if user["role"]not in roles:
            raise HTTPException(403, "Not allowed")
        return user
    return checker