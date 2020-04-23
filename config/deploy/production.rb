set :hanami_env, :production
set :keep_releases, 15
set :asset_roles, %i[app]
set :env_file, '.env.production'

servers = ['superuser@104.248.142.102']

role :app, servers
role :web, servers
role :db, servers
