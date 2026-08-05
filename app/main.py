from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import engine, Base, get_db
from app import models, schemas, crud

# Create tables if they don't already exist
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Trail App PaymentService API",
    description="COMP2001 PaymentService Microservice",
    version="1.0.0"
)


@app.get("/")
def home():
    return {
        "message": "PaymentService API is running successfully"
    }


@app.get("/payments", response_model=list[schemas.Payment])
def read_payments(db: Session = Depends(get_db)):
    return crud.get_payments(db)


@app.get("/payments/{payment_id}", response_model=schemas.Payment)
def read_payment(payment_id: int, db: Session = Depends(get_db)):
    payment = crud.get_payment(db, payment_id)

    if payment is None:
        raise HTTPException(status_code=404, detail="Payment not found")

    return payment


@app.post("/payments", response_model=schemas.Payment)
def create_payment(
    payment: schemas.PaymentCreate,
    db: Session = Depends(get_db)
):
    return crud.create_payment(db, payment)