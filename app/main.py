from fastapi import FastAPI

from app.database import engine, Base
from app.routes import router


# Create database tables
Base.metadata.create_all(bind=engine)


app = FastAPI(
    title="Trail App PaymentService API",
    description="COMP2001 PaymentService Microservice",
    version="1.0.0"
)


# Register payment routes
app.include_router(router)


@app.get("/")
def home():

    return {
        "message": "PaymentService API is running successfully"
    }