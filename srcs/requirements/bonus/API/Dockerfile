ARG DEBIAN_VERSION=bullseye-slim
FROM debian:${DEBIAN_VERSION}

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY conf/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY conf/quotes.py .

EXPOSE 5000

CMD ["python3", "quotes.py"]
