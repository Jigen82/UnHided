FROM python:3.11-slim-bookworm

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends tor \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 7860

CMD ["sh", "-c", "tor --SocksPort 127.0.0.1:9050 --Log 'notice stdout' & exec uvicorn run:main_app --host 0.0.0.0 --port 7860 --workers 1"]
