from sqlalchemy import Column, Integer, Date, String
from app.database import Base


class Payment(Base):
    __tablename__ = "Payment"
    __table_args__ = {"schema": "RCW1"}

    PaymentID = Column(
        Integer,
        primary_key=True,
        index=True
    )

    SubscriptionID = Column(
        Integer,
        nullable=False
    )

    PaymentDate = Column(
        Date,
        nullable=False
    )

    PaymentMethod = Column(
        String(30),
        nullable=False
    )

    TransactionReference = Column(
        String(100),
        nullable=False,
        unique=True
    )