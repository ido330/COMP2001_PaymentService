import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

SERVER = "dist-6-505.uopnet.plymouth.ac.uk"
DATABASE = "COMP2001_SRana"
USERNAME = "SRana"
PASSWORD = "XnrR900"

print("Username:", USERNAME)
print("Password loaded:", PASSWORD is not None)
print("Password length:", len(PASSWORD) if PASSWORD else 0)

connection_string = (
    f"mssql+pyodbc://{USERNAME}:{PASSWORD}@{SERVER}/{DATABASE}"
    "?driver=ODBC+Driver+18+for+SQL+Server"
    "&TrustServerCertificate=yes"
)

engine = create_engine(
    connection_string,
    echo=True
)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

Base = declarative_base()


# Dependency for FastAPI routes
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()