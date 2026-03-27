FROM ruby:3.4.4

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libsqlite3-dev nodejs sqlite3 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "bin/rails db:prepare && bin/rails db:seed && bin/rails server -b 0.0.0.0 -p 3000"]
