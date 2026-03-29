FROM ruby:3.2.8-bullseye

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  git \
  libsqlite3-dev \
  nodejs \
  sqlite3 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock* ./
RUN bundle install

COPY . .

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
