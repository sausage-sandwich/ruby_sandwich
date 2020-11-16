# frozen_string_literal: true

module Web
  module Forms
    module Profile
      module Recipes
        module RecipeIngredients
          class BatchUpdate
            class Mapper < Dry::Transformer::Pipe
              import Dry::Transformer::ArrayTransformations
              import Dry::Transformer::HashTransformations

              define! do
                map_array do
                  accept_keys(%i[protein_g fat_g carbohydrates_g unit_g id])

                  map_value(:protein_g, &:to_mg)
                  map_value(:fat_g, &:to_mg)
                  map_value(:carbohydrates_g, &:to_mg)
                  map_value(:unit_g, &:to_mg)
                  rename_keys(
                    protein_g: :protein_mg,
                    fat_g: :fat_mg,
                    carbohydrates_g: :carbohydrates_mg,
                    unit_g: :unit_mg
                  )
                end
              end

              def to_mg(value)
                return unless value

                (value * 1000).to_i
              end
            end

            attr_reader :params

            def initialize(params)
              @params = params
            end

            def attributes
              Mapper.new.call(@params)
            end
          end
        end
      end
    end
  end
end
