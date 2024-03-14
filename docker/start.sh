!/bin/sh

set -ex

rails db:create || true
rails db:migrate
exec rails s -b '0.0.0.0'