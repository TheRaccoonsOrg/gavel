FROM python:3.9.13-slim

RUN apt update

RUN mkdir /web

WORKDIR /root

RUN apt-get update && apt-get install -y \
    libpq-dev \
    python3-dev \
    gcc \
    postgresql-client

COPY requirements.txt /web/requirements.txt
RUN python -m pip --no-cache-dir install -r /web/requirements.txt

WORKDIR /web

COPY . /web

ENV PORT 5000

EXPOSE ${PORT}

CMD ["python","initialize.py","&&","gunicorn", "-b","0.0.0.0:$PORT","gavel:app","-w","3"]
