import os
import getpass
import psycopg2
from pwdlib import PasswordHash
from config import ( DB_CONFIG )

#password hashing configuration

pwd_context=  PasswordHash.recommended()

#create a database connection

def get_db_connection():
    return psycopg2.connect(**DB_CONFIG)

#ask for administrator information

def get_admin_det():
    
        print("=== Create Initial Administrator ===")
        staff_name =input("Staff name: ").strip()
        username = input("Username: ").strip()
        password= getpass.getpass("Password: ")
        confirm_password= getpass.getpass("Confirm password: ")

        if password!=confirm_password:
            raise ValueError("Password do not match.")
        if not staff_name:
            raise ValueError("Staff name cannot be empty ")
        if not username:
            raise ValueError("Username cannot be empty.")
        if not password:
             raise ValueError("Password cannot be empty. ")
        return staff_name, username, password

# CREATING the administrator in psql

def create_admin():
     staff_name, username, password =get_admin_det()
     password_hash = pwd_context.hash(password)
     connection =None
     cursor= None
     try:
        connection=get_db_connection()
        cursor=connection.cursor()
        cursor.execute(
             """
              INSERT INTO staff(staff_name, role, is_active, username, password_hash)
              VALUES
                  (%s, %s, %s, %s, %s)
              RETURNING staff_uid;
              """,
              (
                   staff_name,
                   "admin",
                   True,
                   username,
                   password_hash
              )
          )
        staff_uid = cursor.fetchone()[0]
        connection.commit()
        print()
        print("Administrator created successfully.")
        print(f"Staff UID:{staff_uid}")
        print(f"Username : {username}")
        print("Role : admin")

     except psycopg2.errors.UniqueViolation:
        if connection:
            connection.rollback()

        print()
        print("error:That username already exists")

     except Exception as error:
         if connection:
             connection.rollback()
         print()
         print("failed to create administrator")
         print(f"Error: {error}")

     finally:
         if cursor:
             cursor.close()
         if connection:
             connection.close()

# running the program main part
if __name__ =="__main__":
    create_admin()

    