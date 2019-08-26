#! /bin/bash

tags=( 2.0.0-p643-slim 2.1.10-slim 2.2.10-slim 2.3.8-slim 2.4.6-slim 2.5.5-slim 2.6.3-slim )

for tag in "${tags[@]}"
do
  docker run --rm \
    -v $PWD:/usr/src/app \
    -w /usr/src/app \
    -e RUBYOPT="-E UTF-8" \
    ruby:$tag /bin/sh -c "apt-get update && apt-get install -y git build-essential patch ruby-dev zlib1g-dev liblzma-dev libxml2 libxslt1-dev && gem install bundler -v 1.17.3 && bundle install && bundle exec rake spec:full"
done
