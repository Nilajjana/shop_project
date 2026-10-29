from fastapi import HTTPException
from sqlalchemy import text
from sqlalchemy.exc import IntegrityError
from auth.security import hash_password
COLUMNS= "staff_uid, staff_name, username, role, is_active"

def _get_staff_or_404(db, staff_uid: int) ->dict:
    row = db.execute(
        text(f"SELECT {COLUMNS} FROM staff WHERE staff_uid = :i"),
        {"i":staff_uid},
    ).mappings().first()
    if row is None:
        raise HTTPException(404, "staff memeber not found")
    return dict(row)

def _refuse_if_admin(target: dict):
    if target["role"] == "admin":
        raise HTTPException(403, "Admin accounts cannot be modified here")

def create_staff(db, data)->dict:
    try:
        row=db.execute(text("INSERT INTO STAFF (staff_name, role,is_active, username, password_hash)"
                            "VALUES (:n,:r,:ia,:u,:p)"
                            f"RETURNING {COLUMNS}"
                            ),
                            {
                                "n":data.staff_name,
                                "r":data.role,
                                "ia":True,
                                "u":data.username,
                                "p":hash_password(data.password),
                            },
                        ).mappings().first()
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(409, "Username already exists")
    return dict(row)

def list_staff(db, include_inactive: bool =True)-> list[dict]:
    query=f"SELECT {COLUMNS} FROM staff "
    if not include_inactive:
        query+= "WHERE is_active "
        query += " ORDER BY staff_uid "
    return [dict(r) for r in db.execute(text(query)).mappings().all()]

def get_staff(db, staff_uid: int)-> dict:
    return _get_staff_or_404(db,staff_uid)

def update_staff(db, staff_uid: int, data)->dict:
    target = _get_staff_or_404(db, staff_uid)
    _refuse_if_admin(target)
    changes={k: v for k, v in  data.model_dump() if v is not None }
    if not changes:
        raise HTTPException(400, "Nothing to update")
    set_clause =", ".join(f"{col} = :{col}" for col in changes)
    row = db.execute(
        text(f"UPDATE staff SET {set_clause} WHERE staff_uid = :uid RETURNING {COLUMNS}"),
        {**changes, "uid": staff_uid},
    ).mappings().first()
    db.commit()
    return dict(row)


def reset_password(db, staff_uid: int, new_password: str):
    target = _get_staff_or_404(db, staff_uid)
    _refuse_if_admin(target)
    db.execute(
        text("UPDATE staff SET password_hash = :p WHERE staff_uid = :i"),
        {"p": hash_password(new_password), "i": staff_uid},
    )
    db.commit()