#!/bin/bash

PATH="/home/deployer/.rvm/gems/ruby-2.4.1/bin:/home/deployer/.rvm/gems/ruby-2.4.1@global/bin:/home/deployer/.rvm/rubies/ruby-2.4.1/bin:/home/deployer/.rvm/gems/ruby-2.4.1/bin:/home/deployer/.rvm/gems/ruby-2.4.1@global/bin:/home/deployer/.rvm/rubies/ruby-2.4.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/deployer/.rvm/bin"
GEM_HOME='/home/deployer/.rvm/gems/ruby-2.4.1'
GEM_PATH='/home/deployer/.rvm/gems/ruby-2.4.1:/home/deployer/.rvm/gems/ruby-2.4.1@global'
MY_RUBY_HOME='/home/deployer/.rvm/rubies/ruby-2.4.1'
IRBRC='/home/deployer/.rvm/rubies/ruby-2.4.1/.irbrc'
RUBY_VERSION='ruby-2.4.1'

dir=$(cd $(dirname $0) && pwd)

echo $dir/../../rvm1scripts/rvm-auto.sh 2.4.1 bundle exec $@ RAILS_ENV=production
$dir/../../rvm1scripts/rvm-auto.sh 2.4.1 bundle exec $@ RAILS_ENV=production
