#!/bin/bash
set -e

echo "Executing bundle exec 'rake db:migrate' ..."
bundle exec rake db:create
bundle exec rake db:migrate
RAILS_ENV=test bundle exec rake db:migrate
bundle exec rake db:bootstrap
bundle exec rake db:seed