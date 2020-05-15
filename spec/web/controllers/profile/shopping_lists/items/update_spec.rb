# frozen_string_literal: true

RSpec.describe Web::Controllers::Profile::ShoppingLists::Items::Update, type: :action do
  let(:action) { described_class.new }
  let(:params) do
    {
      shopping_list_id: shopping_list.id,
      id: shopping_list_item.id,
      shopping_list_item: { checked: 'true' }
    }
  end
  let(:shopping_list) do
    repo = ShoppingListRepository.new
    repo.create(title: 'title')
  end
  let(:shopping_list_item) do
    shopping_list_item_repo.create(
      title: 'title',
      shopping_list_id: shopping_list.id,
      checked: false
    )
  end
  let(:shopping_list_item_repo) { ShoppingListItemRepository.new }
  let(:expected_shopping_list_item) { shopping_list_item_repo.find(shopping_list_item.id) }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
    expect(expected_shopping_list_item).to have_attributes(
      checked: true
    )
  end
end
