# recipe-app
Creating api for recipe app

docker-compose run --rm app sh -c "django-admin startproject app ."


#
1)Create the requirements.txt
2)Create Dockerfile-- steps to build our image-- base image-- add dependcies
3)Create the Dockerfile and put all the steps inside the Dockerfile in order to create a container.
    FROM python:3.9-alpine3.13
    LABEL maintainer=
    ENV PYTHONNUMBUFFERED-----(won't buffered the but print all the python to the console)
