from sqlalchemy.orm import Session
from . import models, schemas


def create_payment(
        db: Session,
        payment: schemas.PaymentCreate
):

    db_payment = models.Payment(
        SubscriptionID=payment.SubscriptionID,
        PaymentDate=payment.PaymentDate,
        PaymentMethod=payment.PaymentMethod,
        TransactionReference=payment.TransactionReference
    )

    db.add(db_payment)
    db.commit()
    db.refresh(db_payment)

    return db_payment



def get_payments(db: Session):

    return db.query(models.Payment).all()



def get_payment(
        db: Session,
        payment_id: int
):

    return db.query(models.Payment)\
        .filter(
            models.Payment.PaymentID == payment_id
        ).first()