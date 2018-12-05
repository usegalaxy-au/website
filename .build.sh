#!/bin/bash
#set -ex
#source /Users/simongladman/miniconda3/envs/galaxy_training_material/bin/ruby

ruby --version
#rvm --version
gem --version

gem install bundler

bundle install
# Check internal links
bundle exec htmlproofer ./_site --check-html --allow-hash-href --assume-extension --disable-external
# Check external
#bundle exec htmlproofer ./_site --check-html --allow-hash-href --assume-extension --external-only
bundle exec jekyll build
