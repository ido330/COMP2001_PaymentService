from pydantic import BaseModel
from datetime import date


class PaymentBase(BaseModel):
    SubscriptionID: int
    PaymentDate: date
    PaymentMethod: str
    TransactionReference: str


class PaymentCreate(PaymentBase):
    pass


class Payment(PaymentBase):
    PaymentID: int

    class Config:
        from_attributes = True