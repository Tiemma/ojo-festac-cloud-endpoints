FROM gcr.io/google-appengine/python

WORKDIR /app

RUN pip install pipenv

ADD app.py Pipfile ./

RUN pipenv install

ENTRYPOINT [ "pipenv", "run", "python", "app.py" ]

EXPOSE 8080