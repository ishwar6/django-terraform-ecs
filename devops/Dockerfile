FROM python:3.10.8 
ENV PYTHONUNBUFFERED 1

COPY /blog/req.txt /tmp/req.txt
COPY /blog/req_dev.txt /tmp/req_dev.txt
COPY /blog /blog
WORKDIR /blog
EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/req.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/req_dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user && \
    chown -R django-user:django-user -R /blog/ 
    

ENV PATH="/scripts:/py/bin:$PATH"

USER django-user
