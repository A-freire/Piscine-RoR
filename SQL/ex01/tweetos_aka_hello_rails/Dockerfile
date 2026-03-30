FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libsqlite3-dev \
    nodejs \
    pkg-config \
    shared-mime-info \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.4.14 && bundle _2.4.14_ install

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "bundle exec rails db:prepare && bundle exec rails server -b 0.0.0.0"]
