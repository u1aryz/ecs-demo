FROM python:3.7
ENV PYTHONUNBUFFERED 1

# Install tools
RUN pip install pipenv

RUN mkdir /app
WORKDIR /app
ADD . /app
# 依存パッケージのインストール
RUN pipenv install

EXPOSE 8080

CMD ["pipenv", "run", "start"]
