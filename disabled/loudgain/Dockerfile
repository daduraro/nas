FROM python:latest

WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
        loudgain \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080
CMD ["python", "-m", "gunicorn", "-b", ":8080", "server"]