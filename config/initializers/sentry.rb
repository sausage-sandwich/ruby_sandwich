# frozen_string_literal: true

require 'raven'

Raven.configure do |config|
  config.dsn = ENV.fetch('SENTRY_DSN')
end
