# frozen_string_literal: true

RSpec.shared_examples 'anonymous user in profile controllers' do
  subject { action.call({ 'rack.session' => session }.merge(params)) }

  let(:session) { { user_id: nil } }

  it 'redirects user' do
    expect(subject[0]).to eq 302
  end
end
