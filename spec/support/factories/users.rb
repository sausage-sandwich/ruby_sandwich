# frozen_string_literal: true

class Factory
  class Users
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
        email: "email#{rand(100_000)}@mail.com",
        password: "123#{rand(100_000)}"
      }
    end

    def repo
      UserRepository.new
    end
  end
end
