# frozen_string_literal: true

module Infrastructure
  module Authentication
    def current_user
      @current_user ||= UserRepository.new.find(session[:user_id])
    end
  end
end
