# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.4.4
FROM ruby:${RUBY_VERSION}-slim

WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config libjemalloc2 sqlite3 libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV RAILS_ENV=development
ENV PORT=3000

EXPOSE 3000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
