FROM python:3.9
LABEL maintainer="Prashant Kumar from iRESAlab"

ENV PYTHONUNBUFFERED 1

EXPOSE 5000
WORKDIR /app
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./scripts /scripts
COPY app /app

ARG DEV=fALSE
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --no-cache-dir --upgrade -r /tmp/requirements.txt && \
    if [ $DEV = true ]; \
       then /py/bin/pip install --no-cache-dir --upgrade -r /tmp/requirements.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user && \
    mkdir -p /vol/web/media && \
    mkdir -p /vol/web/static && \
    chown -R django-user:django-user /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

USER django-user

CMD ["run.sh"]
