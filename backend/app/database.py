import psycopg2
from psycopg2.extras import RealDictCursor 


try:
    conn =psycopg2.connect(host='localhost',database='inventory_db',user='postgres',password='nila416@###',cursor_factory='RealDictCursor')
    cursor=conn.cursor()
    print("Database connection was successful")
except Exception as error:
    print("connection to database was unsuccessful")
    print("Error: ",error)
