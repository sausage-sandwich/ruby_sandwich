# frozen_string_literal: true

set :hanami_env, :production
set :keep_releases, 15
set :asset_roles, %i[app]
set :env_file, '.env.production'

servers = ['superuser@sausage-sandwich.club']

role :app, servers
role :web, servers
role :db, servers
