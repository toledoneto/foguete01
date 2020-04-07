#!/usr/bin/env bash

python manage.py collectstatic --noinput

# wait for Postgres to start
until python manage.py migrate; do
  sleep 2
  echo "migrate not finished!";
done

python manage.py runserver
#gunicorn -w 1 mysite.wsgi -b 0.0.0.0:8000 --daemon
