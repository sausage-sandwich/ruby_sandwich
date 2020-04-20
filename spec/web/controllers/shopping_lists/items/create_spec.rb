# frozen_string_literal: true

RSpec.describe Web::Controllers::ShoppingLists::Items::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { { shopping_list_id: shopping_list.id, shopping_list_item: { title: 'carrot' } } }
  let(:shopping_list) do
    repo = ShoppingListRepository.new
    repo.create(title: 'title')
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
