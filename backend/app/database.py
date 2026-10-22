from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy.orm import sessionmaker
from config import DB_CONFIG

url = URL.create(
    "pstgresql+psycopg2",
    username=DB_CONFIG["user"],password=DB_CONFIG["password"],
    host=DB_CONFIG["host"],port=int(DB_CONFIG["port"]),
    database=DB_CONFIG["dbname"],
)
engine =create_engine(url,pool_pre_ping=True)
SessionLocal = sessionmaker(bind=engine,autoflush=False)
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()