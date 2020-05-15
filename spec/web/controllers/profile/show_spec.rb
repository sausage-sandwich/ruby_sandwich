# frozen_string_literal: true

RSpec.describe Web::Controllers::Profile::Show do
  let(:action) { described_class.new }
  let(:params) { {} }

  it_behaves_like 'anonymous user in profile controllers'

  context 'when user is signed in' do
    include_context 'signed in user'

    it 'is successful' do
      expect(subject[0]).to eq 200
    end
  end
end
