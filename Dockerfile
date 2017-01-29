FROM ruby:2.3.3

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir /app

WORKDIR /app

COPY ./ /app

RUN gem install bundle && \
    bundle install

EXPOSE 3000
