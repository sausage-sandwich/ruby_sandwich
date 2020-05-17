# frozen_string_literal: true

class Factory
  class ShoppingList
    def self.call(**args)
      new(**args).call
    end

    attr_reader :params

    def initialize(**args)
      @params = args.fetch(:params, {})
    end

    def call
      repo.create(generated_params.merge(params))
    end

    private

    def generated_params
      {
        title: "title#{rand(100_000)}"
      }
    end

    def repo
      ShoppingListRepository.new
    end
  end
end
