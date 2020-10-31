# frozen_string_literal: true

module Web
  module Controllers
    module Salad
      class Show
        include Web::Action

        expose :categories
        expose :selected_categories
        expose :salad

        params do
          required(:salad).schema do
            optional(:crunchy).maybe(:bool?)
            optional(:sweet_or_sour).maybe(:bool?)
            optional(:spicy).maybe(:bool?)
            optional(:protein).maybe(:bool?)
          end
        end

        def call(params)
          @categories = GenerateSalad::INGREDIENTS.keys

          submitted_categories = params.to_h.fetch(:salad, {}).select { |_, value| value }.keys
          @selected_categories = [submitted_categories, @categories].detect(&:any?)
          @salad = GenerateSalad.new.call(categories: @selected_categories)
        end
      end
    end
  end
end
