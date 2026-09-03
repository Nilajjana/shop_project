from fastapi import FastAPI
import psycopg2
from psycopg2.extras import RealDictCursor
import time



from config import (
    DB_HOST,
    DB_PORT,
    DB_NAME,
    DB_USER,
    DB_PASSWORD
)

app=FastAPI()

while True:
    try:
        conn = psycopg2.connect( host=DB_HOST,
                                 port=DB_PORT, 
                                 database=DB_NAME, 
                                 user=DB_USER, 
                                 password=DB_PASSWORD, 
                                 cursor_factory=RealDictCursor )
        print("Database connection was successful")
        break
    except Exception as error:
        print("Connection to database was successful")
        print("Error:",error)
        time.sleep(2)

@app.get("/")
def root():
    return {"message":"hello WOrld"}