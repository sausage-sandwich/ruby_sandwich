# frozen_string_literal: true

require 'hanami/interactor'

class CreateUser
  include Hanami::Interactor

  expose :user

  def call(user_params)
    @user = user_repo.create(secured_params(user_params))
  end

  private

  def valid?(params)
    !email_exists?(params.fetch(:email))
  end

  def secured_params(params)
    password = params.fetch(:password)
    password_digest = BCrypt::Password.create(password)
    params.slice(:email, :name).merge(password_digest: password_digest)
  end

  def user_repo
    @user_repo ||= UserRepository.new
  end

  def email_exists?(email)
    !user_repo.find_by_email(email).nil?
  end
end
