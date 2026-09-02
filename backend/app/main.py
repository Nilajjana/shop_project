from fastapi import FastAPI
from fastapi.params import Body
from pydantic import BaseModel
from typing import List
import psycopg2
from psycopg2.extras import RealDictCursor 

while True:
    try:
        conn =psycopg2.connect(host='localhost',database='inventory_db',user='postgres',password='nila416@###',cursor_factory=RealDictCursor)
        cursor=conn.cursor()
        print("Database connection was successful")
        break
    except Exception as error:
        print("connection to database was unsuccessful")
        print("Error: ",error)

app=FastAPI()


@app.get("/post")
def root():
    return{"message": "Hello World"}

@app.post("/post")
def create_posts(new_post:Post):
    print(new_post)
    return{"data":"new post" }