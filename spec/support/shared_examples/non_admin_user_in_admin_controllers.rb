# frozen_string_literal: true

RSpec.shared_examples 'non admin user in admin controllers' do
  subject { action.call({ 'rack.session' => session }.merge(params)) }

  let(:session) { { user_id: user.id } }
  let(:user) { user_repo.create(email: 'non_admin@mail.com', password: '123', admin: false) }
  let(:user_repo) { UserRepository.new }

  it 'redirects user' do
    expect(subject[0]).to eq 404
  end
end
