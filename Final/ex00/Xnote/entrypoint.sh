#!/bin/bash
set -e

mkdir -p /app/tmp/pids /app/log /app/tmp /app/app/assets/images
rm -f /app/tmp/pids/server.pid

if [[ "$*" == *"rails server"* ]]; then
  bundle exec rails db:prepare
fi

exec "$@"
