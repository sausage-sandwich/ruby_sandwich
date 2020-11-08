# frozen_string_literal: true

module Admin
  module Authentication
    def authenticate!
      # binding.pry
      halt(404) unless current_user&.admin?
    end
  end
end
