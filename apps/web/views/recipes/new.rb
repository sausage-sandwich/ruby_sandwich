# frozen_string_literal: true

module Web
  module Views
    module Recipes
      class New
        include Web::View

        def units
          { kg: :kg, g: :g }
        end

        def form
          form_for :recipe, routes.recipes_path, values: { recipe: recipe } do
            label :title, class: 'control-label'
            text_field :title, class: 'form-control'

            label :ingredients, class: 'control-label'

            fields_for_collection :recipe_ingredients do
              div class: 'js-repeatable-block form-group form-inline' do
                text_field :title, class: 'form-control mb-2 mr-2 col-md-6'
                number_field :quantity, class: 'form-control mb-2 mr-2 col-md-1', step: 'any'
                select :unit, units, class: 'form-control mb-2 mr-2 col-md-3'
                div 'Add', class: 'js-repeatable-block-add-button btn btn-warning mb-2 mr-2'
              end
            end

            div class: 'form-group' do
              label :body, class: 'control-label'
              text_area :body, class: 'form-control', rows: 12
            end

            div class: 'form-group' do
              submit 'Submit', class: 'btn btn-primary'
            end
          end
        end
      end
    end
  end
end
