# frozen_string_literal: true

require 'slim'

module Admin
  module Views
    module Ingredients
      class Index
        include Admin::View

        def display_g(value)
          return unless value

          (value / 1000).to_f
        end
      end
    end
  end
end
