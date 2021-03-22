# frozen_string_literal: true

# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch

  add_filter %r{^/spec/}
  add_filter 'config'

  add_group 'Apps', 'apps'
  add_group 'Core', 'lib/sandwich'
end

require_relative '../config/environment'
Hanami.boot
Hanami::Utils.require!("#{__dir__}/support")

RSpec.configure do |config|
  include Helpers::Repositories

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
