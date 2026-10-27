from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from auth.dependency import get_current_user
from app.schemas.staff import StaffCreate, StaffUpdate, ResetPassword
from services import staff_services