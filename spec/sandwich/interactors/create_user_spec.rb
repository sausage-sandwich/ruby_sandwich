# frozen_string_literal: true

RSpec.describe CreateUser do
  subject(:create_user) { described_class.new.call(params) }

  let(:params) do
    {
      email: 'email@email.com',
      name: 'Maria',
      password: password
    }
  end
  let(:password) { 'password' }

  it { expect(create_user).to be_success }
  it { expect(create_user.user).to be }
  it 'encrypts user password' do
    expect(BCrypt::Password.new(create_user.user.password_digest)).to eq password
  end

  context 'when email exists' do
    let(:email) { 'email@email.com' }
    let(:params) do
      {
        email: email,
        name: 'Maria',
        password: 'password'
      }
    end

    before do
      user_repo = UserRepository.new
      user_repo.create(email: email, name: 'name', password: '123')
    end

    it { expect(create_user).to be_failure }
  end
end
