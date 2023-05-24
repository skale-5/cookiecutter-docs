ARG POETRY_VERSION=1.4.2

FROM python:3.10-slim
ARG POETRY_VERSION
ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
# make sure all messages always reach console
    PYTHONUNBUFFERED=1

LABEL org.opencontainers.image.description="Cookiecutter-docs image"
RUN pip install poetry=="${POETRY_VERSION}"

WORKDIR /app
COPY poetry.lock pyproject.toml /app/
# hadolint ignore=DL4006
RUN poetry export -f requirements.txt --without-hashes
COPY . /app
RUN pip install . -U

ENTRYPOINT ["cookicecutter-docs"]
