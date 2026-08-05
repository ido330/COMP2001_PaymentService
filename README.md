# Trail App PaymentService Microservice

## Overview

For the COMP2001 Trail Application, a RESTful microservice called the PaymentService was created.

Payment records related to user subscriptions are managed by the service. It offers FastAPI and SQL Server API methods for generating and obtaining payment data.

---

## Technologies Used

- Python 3
- FastAPI
- SQLAlchemy ORM
- Microsoft SQL Server
- Pydantic
- Uvicorn

---

## Project Structure

```text
COMP2001_PaymentService
│
├── app
│   ├── main.py          # FastAPI application entry point
│   ├── database.py      # Database connection
│   ├── models.py        # SQLAlchemy database models
│   ├── schemas.py       # Pydantic request/response schemas
│   ├── crud.py          # Database operations
│   ├── config.py        # Configuration settings
│   └── auth.py          # Authentication support
│
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── README.md
```