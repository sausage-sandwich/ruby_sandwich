# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.13.0'

set :application, 'sandwich'
set :repo_url, 'git@github.com:sausage-sandwich/ruby_sandwich.git'
set :deploy_to, '/var/www/sandwich'
set :puma_env, fetch(:rack_env, fetch(:hanami_env, 'production'))
set :linked_files, %w[.env.production]

append :linked_dirs, *%w[log tmp/pids tmp/cache tmp/sockets public/system public/uploads]
