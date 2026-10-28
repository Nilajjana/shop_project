from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from auth.dependency import get_current_user, require_role
from schemas.staff import StaffCreate, StaffUpdate, ResetPassword, StaffOut
from services import staff_services

router = APIRouter(prefix="/staff", tags=["staff"])
admin_only = require_role("admin")

@router.post("", response_model=StaffOut, status_code=201)
def create_staff(body: StaffCreate, db=Depends(get_db),uder=Depends(admin_only)):
    return staff_services.create_staff(db,body)

@router.get("", response_model=list[StaffOut])
def list_staff(include_inactive: bool=True,db=Depends(get_db), user=Depends(admin_only)):
    return staff_services.list_staff(db, include_inactive)

@router.get("/{staff_uid}", response_model=StaffOut)
def get_staff(staff_uid: int, db=Depends(get_db), user=Depends(admin_only)):
    return staff_services.get_staff(db, staff_uid)


@router.patch("/{staff_uid}", response_model=StaffOut)
def update_staff(staff_uid: int, body: StaffUpdate, db=Depends(get_db), user=Depends(admin_only)):
    return staff_services.update_staff(db, staff_uid, body)


@router.post("/{staff_uid}/reset-password", status_code=204)
def reset_password(staff_uid: int, body: ResetPassword, db=Depends(get_db), user=Depends(admin_only)):
    staff_services.reset_password(db, staff_uid, body.new_password)