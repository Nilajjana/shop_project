from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from auth.dependency import get_current_user
from schemas.auth import LoginRequest, TokenResponse, CurrentUser
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