FROM ruby:3.3

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  gcc \
  make \
  libc6-dev \
  libpq-dev \
  nodejs \
  postgresql-client \
  git \
  curl && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN gem install bundler rails

COPY . /app