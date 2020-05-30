# frozen_string_literal: true

RSpec.describe Web::Controllers::Profile::ShoppingLists::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { { shopping_list: { title: 'title' } } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
