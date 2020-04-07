# syntax = docker/dockerfile:1.0-experimental
# The line above is MANDATORY as it is, so DON'T CHANGE IT

# ---- Base python ----
FROM python:3.6-slim AS base
# Create app directory
WORKDIR /app

# install app dependencies
RUN apt-get update && apt-get install -y --no-install-recommends build-essential gcc

COPY requirements.txt ./

RUN pip install -r requirements.txt

RUN mkdir log

COPY . /app

# --- Release with Slim ----
FROM python:3.6-slim AS release

# Create user to run as non root
RUN useradd --create-home appuser

# Create app directory
WORKDIR /foguete

# Celery Logging Directories
RUN mkdir -p /var/log/celery
RUN mkdir -p /var/run/celery

COPY --from=base /usr/local/lib/python3.6/site-packages/ /usr/local/lib/python3.6/site-packages/
COPY --from=base /usr/local/bin/ /usr/local/bin/

# Install app dependencies
COPY --from=base /app/ ./

# Creating static directory before non-root user change
#RUN mkdir frontend/static_deploy

# Change permission to non root user
RUN chown -R appuser .
RUN chown -R appuser /var/log/celery

# Don't run as root
USER appuser

ENTRYPOINT ["bash", "docker-entrypoint.sh"]
