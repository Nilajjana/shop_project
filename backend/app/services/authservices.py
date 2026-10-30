from sqlalchemy import text
from auth.security import verify_password, create_access_token, hash_password

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

def change_password(db, staff_uid: int,current_password: str,new_password:str) ->bool:
    row= db.execute(
        text("SELECT password_hash FROM staff WHERE staff_uid= :i AND is_active"),
             {"i": staff_uid},).mappings().first()
    if row is None or not row["password_hash"]:
        return False
    if not verify_password(current_password,row["password_hash"]):
        return False
    db.execute(text("UPDATE staff SET password_hash = :p WHERE staff_uid = :i"),
               {"p": hash_password(new_password),"i":staff_uid},
               )
    db.commit()
    return True