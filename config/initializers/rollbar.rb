require 'rollbar'

Rollbar.configure do |config|
  config.access_token = ENV.fetch('ROLLBAR_ACCESS_TOKEN')
  config.environment = Hanami.env
  config.enabled = !%w[development test].include(Hanami.env)
end
