# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require 'rollbar/middleware/rack'
require_relative '../lib/sandwich'
require_relative '../apps/web/application'
require_relative '../apps/admin/application'

Hanami.configure do
  mount Admin::Application, at: '/admin'
  mount Web::Application, at: '/'

  middleware.use Rollbar::Middleware::Rack

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/sandwich_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/sandwich_development'
    #    adapter :sql, 'mysql://localhost/sandwich_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/sandwich/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger 'daily', level: :info, formatter: :json, filter: %i[password], stream: 'log/production.log'
  end
end
