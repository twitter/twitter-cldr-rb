#! /bin/bash

tags=( 2.3.8-slim 2.4.6-slim 2.5.5-slim 2.6.3-slim 2.7.8-slim 3.0.6-slim 3.1.4-slim 3.2.2-slim )

mv Gemfile.lock Gemfile.lock.old

for tag in "${tags[@]}"
do
  docker run --rm \
    -v $PWD:/usr/src/app \
    -w /usr/src/app \
    -e RUBYOPT="-E UTF-8" \
    ruby:$tag /bin/sh -c "apt-get update && apt-get install -y git build-essential patch ruby-dev zlib1g-dev liblzma-dev libxml2 libxslt1-dev && gem install bundler -v 1.17.3 && bundle install && bundle exec rake spec:full"
done

mv Gemfile.lock.old Gemfile.lock
