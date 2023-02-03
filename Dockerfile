FROM python:3.9
LABEL maintainer="Prashant Kumar from iRESAlab"

ENV PYTHONUNBUFFERED 1

EXPOSE 5000
WORKDIR /app
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

ARG DEV=fALSE
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --no-cache-dir --upgrade -r /tmp/requirements.txt && \
    if [ $DEV = "true"]; \
       then /py/bin/pip install --no-cache-dir --upgrade -r /tmp/requirements.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
