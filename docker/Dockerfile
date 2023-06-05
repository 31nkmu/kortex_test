# pull official base image
FROM python:3.10-slim

# set work directory
WORKDIR /usr/src/code

# set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_HOME='/usr/local' \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_CACHE_DIR='/var/cache/pypoetry'

# install psycopg2 dependencies
RUN apt-get update; \
    apt-get install -y curl make build-essential; \
    curl -sSL https://install.python-poetry.org | python -


# install dependencies
COPY poetry.lock pyproject.toml /usr/src/code
RUN poetry install --no-root --no-dev

# copy project
COPY . .
