FROM python:3.9-alpine3.13
LABEL maintainer="rahul kumar"

#recommended when u are running python inot a docker container
#tells python not to buffered the output
#output from python to be printed directly to the console
#which prevents delay the printing of any output fromm application to display on the screen

ENV PYTHONUNBUFFERED 1


COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.text

COPY ./app /app

WORKDIR /app

EXPOSE 8000

ARG DEV=false
#don't put multiple run commands as it add layers and make ur image heavyweight
#create a virtual env so that, there is no conflicts between the pyhton image packages
# and requiremets on
# add user to the image as it is best practises to not use the root user
RUN python -m venv /py && \
        /py/bin/pip install --upgrade pip && \
        apk add --update --no-cache postgresql-client && \
        apk add --update --no-cache --virtual .tmp-build-deps \
            build-base postgresql-dev musl-dev && \
        /py/bin/pip install -r /tmp/requirements.txt && \
        if [ $DEV = "true"]; \ 
            then /py/bin/pip install -r /tmp/requirements.dev.txt; \
        fi && \
        rm -rf /tmp && \
        apk del .tmp-build-deps && \
        adduser \
           --disabled-password \
           --no-create-home \
           django-user
# update env variable inside the image, all dir excutables run
ENV PATH="/py/bin:$PATH"

USER django-user