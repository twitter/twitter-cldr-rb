#! /bin/bash

locale=$1

if [[ $locale == "" ]]; then
  echo "Please specify a locale as a command-line argument."
  exit 1
fi

which rbenv > /dev/null

if [[ $? == "0" ]]; then
  echo "rbenv detected"
  manager="rbenv"
else
  which rvm > /dev/null

  if [[ $? == "0" ]]; then
    echo "rvm detected"
    manager="rvm"
  else
    echo "Couldn't detect a Ruby version manager (tried rbenv and rvm)"
    exit 2
  fi
fi

if [[ $manager == "rbenv" ]]; then
  jruby_version="jruby-9.2.8.0"
  mri_version="2.6.2"

  if [[ $(rbenv versions | grep $mri_version) == "" ]]; then
    echo "Installing $mri_version"
    rbenv install $mri_version
  fi

  rbenv local $mri_version
  ruby -v
else
  jruby_version="jruby-9.2.8.0"
  mri_version="ruby-2.6.2"

  if [[ $(rvm list | grep $mri_version) == "" ]]; then
    echo "Installing $mri_version"
    rvm install $mri_version
  fi

  rvm use $mri_version
  ruby -v
fi

bundle install
bundle exec rake add_locale[$locale]

if [[ $manager == "rbenv" ]]; then
  if [[ $(rbenv versions | grep $jruby_version) == "" ]]; then
    echo "Installing $jruby_version"
    rbenv install $jruby_version
  fi

  rbenv local $jruby_version
  ruby -v
else
  if [[ $(rvm list | grep $jruby_version) == "" ]]; then
    echo "Installing $jruby_version"
    rvm install $jruby_version
  fi

  rvm use $jruby_version
  ruby -v
fi

# increase heap size to avoid out of memory errors
export JAVA_OPTS="-Xmx1G"

bundle install
bundle exec rake add_locale[$locale]
