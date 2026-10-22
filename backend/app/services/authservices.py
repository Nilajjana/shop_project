from sqlalchemy import text
from auth.security import verify_password, create_access_token

def login(db, username: str, password: str):
    row= db.execute(
        text("SELECT staff_uid, role,password_hash FROM staff "
             "WHERE username=:u AND is_active"),
             {"u":username},
        ).mappings().first()
    if row is None or not row["password_hash"]:
        return None
    if not verify_password(password, row["password_hash"]):
        return None
    return create_access_token({"sub": str(row["staff_uid"]),"role": row["role"]})
    