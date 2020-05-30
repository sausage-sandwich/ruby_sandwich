# frozen_string_literal: true

RSpec.describe Web::Controllers::Profile::ShoppingLists::Index, type: :action do
  it_behaves_like 'anonymous user in profile controllers'

  include_context 'signed in user'

  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    expect(subject[0]).to eq 200
  end
end
