FROM python:3.11-alpine

WORKDIR /app

RUN pip install flask

COPY . /app

EXPOSE 5000

ENV APP_ENV=producao
ENV APP_COLOR=#232f3e

CMD ["python", "app.py"]
