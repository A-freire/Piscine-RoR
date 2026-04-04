FROM ruby:3.0.2-bullseye

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libpq-dev git curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    RAILS_ENV=production

RUN gem install bundler -v 2.4.14 --no-document

COPY Gemfile Gemfile.lock ./
RUN bundle _2.4.14_ install

COPY . .

RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

ENTRYPOINT ["./bin/docker-entrypoint"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
