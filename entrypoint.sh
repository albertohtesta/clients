#!/usr/bin/env sh

set -e

if [ -f /clients-backend/tmp/pids/server.pid ]; then
  rm /clients-backend/tmp/pids/server.pid
fi

bundle install &
bundle exec rails db:migrate &
bundle exec rake sneakers:run &



exec "$@"
