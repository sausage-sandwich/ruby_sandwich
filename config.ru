# frozen_string_literal: true

require './config/environment'

use Raven::Rack
run Hanami.app
