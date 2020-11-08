# frozen_string_literal: true

RSpec.shared_context 'signed in admin', type: :action do
  subject { action.call({ 'rack.session' => session }.merge(params)) }

  let(:session) { { user_id: user.id } }
  let(:user) { user_repo.create(email: 'email1@mail.com', password: '123', admin: true) }
  let(:user_repo) { UserRepository.new }
end
