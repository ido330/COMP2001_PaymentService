FROM python:3.12

WORKDIR /app

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unixodbc \
    unixodbc-dev \
    ca-certificates


RUN curl https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    > /usr/share/keyrings/microsoft-prod.gpg


RUN curl https://packages.microsoft.com/config/debian/12/prod.list \
    | tee /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18


COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt


COPY . .


CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]