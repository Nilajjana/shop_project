from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from auth.dependency import get_current_user
from schemas.auth import LoginRequest, TokenResponse, CurrentUser,ChangePasswordRequest
from services import authservices

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/login", response_model=TokenResponse)
def login(body: LoginRequest, db=Depends(get_db)):
    token = authservices.login(db, body.username, body.password)
    if token is None:
        raise HTTPException(401, "Invalid username or password")
    return TokenResponse(access_token=token)

@router.get("/me", response_model=CurrentUser)
def me(user=Depends(get_current_user)):
    return user
@router.get("/me",response_model=CurrentUser)
def me(user=Depends(get_current_user)):
    return user
@router.post("/change-password",status_code=204)
def change_password(body:ChangePasswordRequest,db=Depends(get_db),user=Depends(get_current_user)):
    ok=authservices.change_password(db, user["staff_uid"], body.current_password,body.new_password)
    if not ok:
        raise HTTPException(400,"Current password is incorrect")