# frozen_string_literal: true

require 'rake'
require 'hanami/rake_tasks'
require 'rollbar/rake_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end
