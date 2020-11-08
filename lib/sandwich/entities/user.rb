# frozen_string_literal: true

class User < Hanami::Entity
  def admin?
    admin
  end
end
