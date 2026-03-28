ARG RUBY_VERSION=3.4.4
FROM ruby:${RUBY_VERSION}-slim

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git pkg-config libxml2-dev libxslt1-dev && \
    rm -rf /var/lib/apt/lists/*

CMD ["sleep", "infinity"]
