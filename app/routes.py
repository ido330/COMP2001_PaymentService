from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app import schemas, crud


router = APIRouter(
    prefix="/payments",
    tags=["Payments"]
)


@router.get("/", response_model=list[schemas.Payment])
def read_payments(db: Session = Depends(get_db)):

    return crud.get_payments(db)



@router.get("/{payment_id}", response_model=schemas.Payment)
def read_payment(
    payment_id: int,
    db: Session = Depends(get_db)
):

    payment = crud.get_payment(db, payment_id)

    if payment is None:
        raise HTTPException(
            status_code=404,
            detail="Payment not found"
        )

    return payment



@router.post("/", response_model=schemas.Payment)
def create_payment(
    payment: schemas.PaymentCreate,
    db: Session = Depends(get_db)
):

    return crud.create_payment(db, payment)