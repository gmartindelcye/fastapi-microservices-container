FROM python:3.10-slim-buster

RUN mkdir -p /app
COPY . main,py /app/
WORKDIR /app
COPY pyproject.toml /app/pyproject.toml
COPY poetry.lock /app/poetry.lock
RUN pip install pdm
RUN pdm install
RUN python -m textblob.download_corpora
EXPOSE 8080
CMD [ "main.py" ]
ENTRYPOINT [ "python" ] 
